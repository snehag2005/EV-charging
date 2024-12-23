from flask import Flask, render_template, request, flash, jsonify, url_for,redirect,session
from flask_mysqldb import MySQL
from flask_mail import Mail, Message
from datetime import datetime, timedelta
from datetime import date as d
from datetime import datetime
import json

app = Flask(__name__, static_url_path='/static')
app.secret_key="Ayush@2041"

app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587  # Use 465 for secure connections
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False
app.config['MAIL_USERNAME'] = 'checkin12390@gmail.com'
app.config['MAIL_PASSWORD'] = 'dtvtxofktnxijekn'
app.config['MAIL_DEFAULT_SENDER'] = 'checkin12390@example.com'
# Configure MySQL
# app.config['MYSQL_HOST'] = 'bz6lj0wtuursoqtkhwfx-mysql.services.clever-cloud.com'
# app.config['MYSQL_USER'] = 'ujxcnt7zsraho8ba'
# app.config['MYSQL_PASSWORD'] = 'hPBWgC9viBAiM2UCVkJb'
# app.config['MYSQL_DB'] = 'bz6lj0wtuursoqtkhwfx'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'bankdb'

# Initialize Flask-Mail
mail = Mail(app)
mysql = MySQL(app)


def get_user_by_email(email):
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM users WHERE email = %s", (email,))
    user = cur.fetchone()
    cur.close()
    return user
class Area:
    def __init__(self, area):
        
        self.area = area

class Company:
    def __init__(self, id, name, email,phone,gst,tspace,connector_types,charge_levels,dc_support,address,area,taluka,state):
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.gst = gst
        self.tspace = tspace
        self.connector_types = connector_types
        self.charge_levels = charge_levels
        self.dc_support = dc_support
        self.address = address
        self.area = area
        self.taluka = taluka
        self.state = state

class Company_details:
    def __init__(self, id, name, email,phone,gst,tspace,connector_types,charge_levels,dc_support,address,area,taluka,state):
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.gst = gst
        self.tspace = tspace
        self.connector_types = connector_types
        self.charge_levels = charge_levels
        self.dc_support = dc_support
        self.address = address
        self.area = area
        self.taluka = taluka
        self.state = state

@app.route('/', methods=['GET', 'POST'])
def index():
    usertype = None
    name=None
    email=None
    station_owner ='station_owner'
    if 'usertype' in session and session['usertype'] == 'user' and 'email' in session and 'name' in session:

        usertype = session['usertype']
        email = session['email']
        name = session['name']
    cur = mysql.connection.cursor()

    # Fetch areas
    cur.execute("SELECT distinct area FROM users where usertype=%s",(station_owner,))
    areas_data = cur.fetchall()
    areas = [Area(area=row[0]) for row in areas_data]
    
    selected_area = None
    registered_companies = []

    # Fetch companies if area is selected
    if request.method == 'POST':
        selected_area = request.form.get('selected_option')# name of text box of location
        


        if selected_area:
            cur.execute("SELECT id, name,email,phone,gst,tspace,connector_types,charge_levels,dc_support,address,area,taluka,state  FROM users WHERE area = %s and usertype=%s", (selected_area,station_owner,))
            companies_data = cur.fetchall()
            registered_companies = [Company(id=row[0], name=row[1], email=row[2],phone=row[3],gst=row[4], tspace=row[5], connector_types=row[6],charge_levels=row[7],dc_support=row[8], address=row[9], area=row[10],taluka=row[11],state=[12]) for row in companies_data]

            
        else:
            flash('Invalid area selected', 'danger')

    cur.close()

    return render_template('index.html', areas=areas, selected_area=selected_area, registered_companies=registered_companies,usertype=usertype,name=name,email=email)

@app.route('/company_details/<int:company_id>')
def company_details(company_id):
    usertype = None
    name=None
    email=None
    if 'usertype' in session and session['usertype'] == 'user' and 'email' in session and 'name' in session:

        usertype = session['usertype']
        email = session['email']
        name = session['name']
    
        cur = mysql.connection.cursor()
        cur.execute("SELECT id, name,email,phone,gst,tspace,connector_types,charge_levels,dc_support,address,area,taluka,state  FROM users WHERE id = %s", (company_id,))
        companies_datas = cur.fetchall()
        registered_companies = [Company_details(id=row[0], name=row[1], email=row[2],phone=row[3],gst=row[4], tspace=row[5], connector_types=row[6],charge_levels=row[7],dc_support=row[8], address=row[9], area=row[10],taluka=row[11],state=row[12]) for row in companies_datas]
        # company_details = get_company_details(company_id)

    # Pass the company details to the template
        return render_template('company_details.html', registered_companies=registered_companies,usertype=usertype,name=name,email=email)
    flash('Session information is missing. Please log in.', 'danger')
    return redirect(url_for('login', flash_message='You Cant Book without logging in'))

# Function to generate time slots for a 24-hour period with a specified interval
def generate_time_slots(interval_minutes=15):
    start_time = 0
    end_time = 24 * 60  # 24 hours in minutes
    time_slots = []

    while start_time < end_time:
        end_slot = start_time + interval_minutes
        time_format = '{:02d}:{:02d} - {:02d}:{:02d}'
        time_slots.append(time_format.format(start_time // 60, start_time % 60, end_slot // 60, end_slot % 60))
        start_time = end_slot
    
    
    return time_slots


def getConnectorTypePrice(connector_type):
    # Prices for each connector type (per 15 minutes)
    prices = {
        'Type 1': 10,
        'Type 2': 12,
        'Type 3': 15
    }

    # Return the price for the given connector type
    return prices.get(connector_type, 0)


@app.route('/book_port/<int:company_id>', methods=['GET', 'POST'])
def book_port(company_id):
    usertype = None
    name = None
    email = None

    if 'usertype' in session and session['usertype'] == 'user' and 'email' in session and 'name' in session:
        usertype = session['usertype']
        email = session['email']
        name = session['name']

        cur = mysql.connection.cursor()
        cur.execute("SELECT id, name, email, phone, gst, tspace, connector_types, charge_levels, dc_support, address, area, taluka, state FROM users WHERE id = %s", (company_id,))
        companies_datas = cur.fetchall()
        registered_companies = [Company_details(id=row[0], name=row[1], email=row[2], phone=row[3], gst=row[4], tspace=row[5], connector_types=row[6], charge_levels=row[7], dc_support=row[8], address=row[9], area=row[10], taluka=row[11], state=row[12]) for row in companies_datas]

        

        # Fetch connector type options from the database
        cur.execute("SELECT DISTINCT connector_types FROM users WHERE id = %s", (company_id,))
        connector_type_options = [row[0] for row in cur.fetchall()]

        # Fetch charge level options from the database
        cur.execute("SELECT DISTINCT charge_levels FROM users WHERE id = %s", (company_id,))
        charge_level_options = [row[0] for row in cur.fetchall()]

        time_slots = generate_time_slots()

        bookingdate = d.today()
        formatted_time = datetime.now().time()
        bookingtime = formatted_time.strftime('%H:%M')
        selectedport = request.form.get('selectedport')
        
        cur = mysql.connection.cursor()
        cur.execute("SELECT `starttime`, `endtime` FROM `bookings` WHERE bookingdate = %s and selectedport =%s and status=%s", (bookingdate,selectedport,'Booked',))
        booked_data = cur.fetchall()
        
        
        
        
        if request.method == 'POST':
            
            selectedport = request.form.get('selectedport')
            selectedtype = request.form.get('selectedConnectorType')
            selectedlevel = request.form.get('selectedChargeLevel')

            if selectedport  and selectedtype and selectedlevel:
                return render_template('book_slot.html',selectedport=selectedport,selectedtype = selectedtype,selectedlevel=selectedlevel,company_id=company_id,usertype=usertype, name=name, email=email,connector_type_options=connector_type_options, charge_level_options=charge_level_options, time_slots=time_slots,getConnectorTypePrice=getConnectorTypePrice,booked_data=json.dumps(booked_data))
            else:
               
                flash("Please fill out all fields", 'danger')
                return render_template('book_port.html',flash_message='Please fill out all fields',company_id=company_id, registered_companies=registered_companies, usertype=usertype, name=name, email=email, connector_type_options=connector_type_options, charge_level_options=charge_level_options, time_slots=time_slots,getConnectorTypePrice=getConnectorTypePrice)


            

        return render_template('book_port.html', company_id=company_id, registered_companies=registered_companies, usertype=usertype, name=name, email=email, connector_type_options=connector_type_options, charge_level_options=charge_level_options, time_slots=time_slots,getConnectorTypePrice=getConnectorTypePrice)

    return render_template('book_port.html', company_id=company_id)

@app.route('/book_slot/<int:company_id>', methods=['GET', 'POST'])
def book_slot(company_id):
    usertype = None
    name = None
    email = None

    if 'usertype' in session and session['usertype'] == 'user' and 'email' in session and 'name' in session:
        usertype = session['usertype']
        email = session['email']
        name = session['name']

        cur = mysql.connection.cursor()
        cur.execute("SELECT id, name, email, phone, gst, tspace, connector_types, charge_levels, dc_support, address, area, taluka, state FROM users WHERE id = %s", (company_id,))
        companies_datas = cur.fetchall()
        registered_companies = [Company_details(id=row[0], name=row[1], email=row[2], phone=row[3], gst=row[4], tspace=row[5], connector_types=row[6], charge_levels=row[7], dc_support=row[8], address=row[9], area=row[10], taluka=row[11], state=row[12]) for row in companies_datas]
        
        if request.method == 'POST':
            
            
            cur = mysql.connection.cursor()
            cur.execute("SELECT id, name, email, phone,vehicle, area, taluka, state FROM users WHERE email = %s", (email,))
            user_details = cur.fetchone()

            userphone = user_details[3]
            useraddress = user_details[4]
            userarea =  user_details[5]
            stationname = registered_companies[0].name
            stationemail = registered_companies[0].email
            stationphone = registered_companies[0].phone
            stationaddress = registered_companies[0].address
            stationarea = registered_companies[0].area
            selectedport = request.form.get('selectedport')
            selectedtype = request.form.get('selectedtype')
            selectedlevel = request.form.get('selectedlevel')
            starttime = request.form.get('startSlot')
            endtime = request.form.get('endSlot')
            totaltime = request.form.get('totalHours')
            totalcost = request.form.get('totalCost')
            bookingdate = d.today()
            formatted_time = datetime.now().time()
            bookingtime = formatted_time.strftime('%H:%M')
            time = starttime.split(" - ")
            time1 = time[0].split(":")
            st1 = int(time1[0]) - 1
            st = str(st1) + ":" + time1[1]


            totalc=totalcost.split(' ')
            
            import razorpay

            # Set your Razorpay API key and secret
            razorpay_key_id = 'rzp_test_QrXwl6OhdHsI5b'
            razorpay_key_secret = '4uX0ZE6APBpcaUOZGQcD8hYt'

            client = razorpay.Client(auth=(razorpay_key_id, razorpay_key_secret))
            amount = totalc[0]
            order_currency = 'INR'  # You can change it to your preferred currency
            order_receipt = 'order_receipt'
            order_notes = {'Shipping address': 'Bommanahalli, Bangalore'}

            # Create order
            order = client.order.create({
                'amount': amount,
                'currency': order_currency,
                'receipt': order_receipt,
                'notes': order_notes
            })
            

           
            
            cur = mysql.connection.cursor()
            cur.execute("INSERT INTO `bookings`( `username`, `useremail`, `userphone`, `useraddress`, `userarea`, `stationname`, `stationemail`, `stationphone`, `stationaddress`, `stationarea`, `selectedport`, `selectedtype`, `selectedlevel`, `starttime`, `endtime`, `totaltime`, `totalcost`, `bookingtime`, `bookingdate`,`st`,`status`) VALUES (%s,%s ,%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s, %s, %s,%s, %s, %s,%s)", 
                        (name, email, userphone, useraddress, userarea, stationname, stationemail, stationphone, stationaddress, stationarea ,selectedport , selectedtype , selectedlevel ,starttime ,endtime ,totaltime ,totalcost ,bookingtime ,bookingdate,st,'Booked'))
            mysql.connection.commit()
            cur.close()

            cur = mysql.connection.cursor()
            cur.execute("SELECT `username`, `useremail`, `userphone`, `useraddress`, `userarea`, `stationname`, `stationemail`, `stationphone`, `stationaddress`, `stationarea`, `selectedport`, `selectedtype`, `selectedlevel`, `starttime`, `endtime`, `totaltime`, `totalcost`, `bookingtime`, `bookingdate` FROM `bookings` WHERE bookingdate = %s and bookingtime= %s and useremail =%s and stationemail = %s ",(bookingdate,bookingtime,email,stationemail,))
            bill_details=cur.fetchone()
            mysql.connection.commit()
            cur.close()

            if totalcost :
                
                return  render_template('bill.html',company_id=company_id, registered_companies=registered_companies,bill_details=bill_details,usertype=usertype, name=name, email=email)
            else:
                flash("Please fill out all fields", 'danger')
                cur = mysql.connection.cursor()
                cur.execute("SELECT id, name, email, phone, gst, tspace, connector_types, charge_levels, dc_support, address, area, taluka, state FROM users WHERE id = %s", (company_id,))
                companies_datas = cur.fetchall()
                registered_companies = [Company_details(id=row[0], name=row[1], email=row[2], phone=row[3], gst=row[4], tspace=row[5], connector_types=row[6], charge_levels=row[7], dc_support=row[8], address=row[9], area=row[10], taluka=row[11], state=row[12]) for row in companies_datas]

                

                # Fetch connector type options from the database
                cur.execute("SELECT DISTINCT connector_types FROM users WHERE id = %s", (company_id,))
                connector_type_options = [row[0] for row in cur.fetchall()]

                # Fetch charge level options from the database
                cur.execute("SELECT DISTINCT charge_levels FROM users WHERE id = %s", (company_id,))
                charge_level_options = [row[0] for row in cur.fetchall()]

                time_slots = generate_time_slots()

                bookingdate = d.today()
                formatted_time = datetime.now().time()
                bookingtime = formatted_time.strftime('%H:%M')
                selectedport = request.form.get('selectedport')
                
                cur = mysql.connection.cursor()
                cur.execute("SELECT `starttime`, `endtime` FROM `bookings` WHERE bookingdate = %s and selectedport =%s and status=%s", (bookingdate,selectedport,'Booked',))
                booked_data = cur.fetchall()
                
                return render_template('book_slot.html',selectedport=selectedport,selectedtype = selectedtype,selectedlevel=selectedlevel,company_id=company_id,usertype=usertype, name=name, email=email,connector_type_options=connector_type_options, charge_level_options=charge_level_options, time_slots=time_slots,getConnectorTypePrice=getConnectorTypePrice,booked_data=json.dumps(booked_data))


        return render_template('book_slot.html', company_id=company_id, registered_companies=registered_companies, usertype=usertype, name=name, email=email)

    return render_template('book_port.html', company_id=company_id)

@app.route('/bill/<int:company_id>', methods=['GET', 'POST'])
def bill(company_id):
    usertype = None
    name = None
    email = None

    if 'usertype' in session and session['usertype'] == 'user' and 'email' in session and 'name' in session:
        usertype = session['usertype']
        email = session['email']
        name = session['name']

        cur = mysql.connection.cursor()
        cur.execute("SELECT id, name, email, phone,vehicle, area, taluka, state FROM users WHERE email = %s", (email,))
        user_details = cur.fetchone()
    return render_template('bill.html', company_id=company_id, usertype=usertype, email=email, name=name)



@app.route('/update_details.html', methods=['GET', 'POST'])
def update_profile():
    print("Entering update_profile route")
    if 'usertype' in session and 'email' in session and 'name' in session:
        usertype = session['usertype']
        email = session['email']
        name = session['name']

        cur = mysql.connection.cursor()
        cur.execute("SELECT name, email, phone, gst, tspace, connector_types, charge_levels, dc_support, address, area, taluka, state FROM users WHERE email=%s", (email,))
        user_data = cur.fetchone()
        cur.close()

        print("User Data:", user_data)

        if request.method == 'POST':
            # Handle form submission and update the database
            name = request.form['name']
            phone = request.form['phone']
            gst = request.form['gst']
            tspace = request.form['tspace']
            connector_type = ', '.join(request.form.getlist('connector_type')) if 'connector_type' in request.form else 'None'
            charge_level = ', '.join(request.form.getlist('charge_level')) if 'charge_level' in request.form else 'None'
            dc_supports= 'dc_support' in request.form
            address = request.form['address']
            area = request.form['area']
            taluka = request.form['taluka']
            state = request.form['state']

            cur = mysql.connection.cursor()
            cur.execute("UPDATE users SET name=%s, phone=%s, gst=%s, tspace=%s, connector_types=%s, charge_levels=%s, dc_support=%s, address=%s, area=%s, taluka=%s, state=%s WHERE email=%s",
                        (name, phone, gst, tspace, connector_type, charge_level, dc_supports, address, area, taluka, state, email))
            mysql.connection.commit()
            cur.close()

            # Redirect to the updated profile
            return redirect(url_for('update_profile'))

        return render_template('update_details.html', usertype=usertype, email=email, name=name, user_data=user_data)
    else:
        return redirect(url_for('login'))
    

@app.route('/dashboard.html',methods=['GET','POST'])
def dashboard():
    usertype = None
    name=None
    email=None
    if 'usertype' in session and session['usertype'] == 'station_owner' and 'email' in session and 'name' in session:
        usertype = session['usertype']
        email = session['email']
        name = session['name']

        cur = mysql.connection.cursor()
        cur.execute("SELECT connector_types,charge_levels,dc_support FROM users where  email=%s", (email,))
        details = cur.fetchall()
        cur.close()

        # Default values in case the form is not submitted
        connector_types_str = 'None'
        charge_levels_str = 'None'
        dc_support = False

        if request.method == 'POST':
            # Get selected connector types
            connector_types = request.form.getlist('connector_type')
            connector_types_str = ', '.join(connector_types) if connector_types else 'None'

            # Get selected charge levels
            charge_levels = request.form.getlist('charge_level')
            charge_levels_str = ', '.join(charge_levels) if charge_levels else 'None'

            # Check if DC support is selected
            dc_support = 'dc_support' in request.form

            # Insert or update data into the database
            cur = mysql.connection.cursor()
            cur.execute("UPDATE users SET connector_types = %s, charge_levels = %s, dc_support = %s WHERE email = %s",
                        (connector_types_str, charge_levels_str, dc_support, email))
            mysql.connection.commit()
            cur.close()

            return redirect(url_for('update_profile'))


        return render_template('dashboard.html', usertype=usertype, email=email, name=name,details=details)
    else:
        return redirect(url_for('login'))





@app.route('/bookings_admin.html', methods=['GET', 'POST'])
def bookings_admin():
    if 'usertype' in session and 'email' in session and 'name' in session:
        usertype = session['usertype']
        email = session['email']
        name = session['name']

        cur = mysql.connection.cursor()
        cur.execute("SELECT `username`, `useremail`, `userphone`, `useraddress`, `userarea`,  `selectedport`, `selectedtype`, `selectedlevel`, `starttime`, `endtime`, `totaltime`, `totalcost`, `bookingtime`, `bookingdate` FROM bookings WHERE stationemail=%s and status=%s", (email,'Booked',))
        booking_data = cur.fetchall()
        cur.close()
        

        return render_template('bookings_admin.html', booking_data=booking_data,usertype=usertype,email=email,name=name)
    else:
        # Redirect the user to the login page if not logged in
        return redirect(url_for('login'))
    

@app.route('/cancelled_bookingsadmin.html', methods=['GET', 'POST'])
def cancelled_bookingsadmin():
    if 'usertype' in session and 'email' in session and 'name' in session:
        usertype = session['usertype']
        email = session['email']
        name = session['name']

        cur = mysql.connection.cursor()
        cur.execute("SELECT `username`, `useremail`, `userphone`, `useraddress`, `userarea`,  `selectedport`, `selectedtype`, `selectedlevel`, `starttime`, `endtime`, `totaltime`, `totalcost`, `bookingtime`, `bookingdate` FROM bookings WHERE stationemail=%s and status=%s", (email,'Cancelled',))
        booking_data = cur.fetchall()
        cur.close()
        

        return render_template('cancelled_bookingsadmin.html', booking_data=booking_data,usertype=usertype,email=email,name=name)
    else:
        # Redirect the user to the login page if not logged in
        return redirect(url_for('login'))




@app.route('/login_dashboard.html', methods=['POST','GET'])
def login():
    alert_message = None
    # Retrieve the flash message from the URL parameters
    flash_message = request.args.get('flash_message')
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        # Check the database for the provided username and password
        cur = mysql.connection.cursor()
        cur.execute("SELECT usertype,email,name FROM users WHERE email = %s AND password = %s", (email, password))
        user = cur.fetchone()
        cur.close()

        if user:
            # Successful login, redirect to the index page
            session['usertype'] = user[0]
            session['email'] = user[1]
            session['name'] = user[2]

            if session['usertype'] == 'station_owner':
                # Redirect to the dashboard
                return redirect(url_for('dashboard'))
            else:
                # Redirect to the previous page
                return redirect(url_for('index'))
            
        else:
            # Incorrect username or password, show error message
            alert_message='Invalid username or password. Please try again.'
    # Render the login template with flash message
    flash(flash_message, 'danger') if flash_message else None
    return render_template('login_dashboard.html', alert_message=alert_message)
    


from itsdangerous import URLSafeTimedSerializer
from flask_mail import Message

serializer = URLSafeTimedSerializer(app.secret_key)

@app.route('/forgot_password.html', methods=['GET', 'POST'])
def forgot_password():
    alert_message = ""
    if request.method == 'POST':
        email = request.form.get('email')

        user = get_user_by_email(email)
        if user:
            # Generate a unique token for the user with a 10-minute expiration time
            expiration_time = datetime.utcnow() + timedelta(minutes=10)
            token = serializer.dumps({'email': email, 'exp': expiration_time.timestamp()}, salt='password-reset')

            reset_link = url_for('change_password', token=token, _external=True)
            send_password_reset_email(email, reset_link)

            return redirect(url_for('forgot_password'))

        alert_message = "User not found"

    return render_template('forgot_password.html', alert_message=alert_message)


def send_password_reset_email(email, reset_link):
    alert_message = ""
    subject = 'Password Reset Request'
    body = f'Click the following link to reset your password: {reset_link}'

    msg = Message(subject, recipients=[email], body=body)
    
    try:
        mail.send(msg)
        alert_message = "An email has been sent to you with instructions"
    except Exception as e:
        alert_message = f"Error sending email: {str(e)}"
    return alert_message
    


@app.route('/change_password/<token>', methods=['GET', 'POST'])
def change_password(token):
    alert_message = ""

    try:
        # Load the token and check if it's still valid
        data = serializer.loads(token, salt='password-reset', max_age=600)  # 10 minutes (in seconds)
        email = data.get('email')

        if request.method == 'POST':
            password = request.form['password']
            confirmpassword = request.form['confirmpassword']

            cur = mysql.connection.cursor()
            cur.execute("UPDATE users SET password=%s, confirmpassword=%s WHERE email=%s",
                        (password, confirmpassword, email))
            mysql.connection.commit()
            cur.close()

            if cur.rowcount > 0:
                alert_message = 'Password Changed'
                return redirect(url_for('login'))
            else:
                alert_message = "Can't Change Password"

    except Exception as e:
        alert_message = f"Invalid or expired token: {str(e)}"

    return render_template('change_password.html', alert_message=alert_message)




@app.route('/logout', methods=['POST'])
def logout():
    # Clear the session
    session.clear()
   
    # Return a response, if needed
    return render_template('login_dashboard.html')
       
@app.route('/register_dashboard.html', methods=['POST','GET'])
def register():
    alert_message = None

    if request.method == 'POST':
        # Extract form data
        usertype = "station_owner"
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']
        confirmpassword = request.form['confirmpassword']
        phone = request.form['phone']
        gst = request.form['gst']
        tspace = request.form['tspace']
        address = request.form['address']  # Corrected the field name
        area = request.form['area']
        taluka = request.form['taluka']
        state = request.form['state']

        # Check if the email is already in the database
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM users WHERE email = %s", (email,))
        existing_user = cur.fetchone()
        cur.close()

        if existing_user:
            # Email is not unique; handle the situation (set alert message)
            alert_message = 'Email already exists. Please choose a different email.'
            
            return render_template('register_dashboard.html', alert_message=alert_message)
            

        # Email is unique; proceed with the insertion
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO users (usertype, name, email, phone, password, confirmpassword, gst, tspace, address, area, taluka, state) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", 
                    (usertype, name, email, phone, password, confirmpassword, gst, tspace, address, area, taluka, state))
        mysql.connection.commit()
        cur.close()

        # Set success message
        alert_message = 'Registration successful!'
        return redirect(url_for('login'))

    # Render the template with the alert message
    return render_template('register_dashboard.html', alert_message=alert_message)


@app.route('/user_register.html', methods=['POST','GET'])
def user_register():
    alert_message = None

    if request.method == 'POST':
        # Extract form data
        usertype = "user"
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']
        confirmpassword = request.form['confirmpassword']
        phone = request.form['phone']
        vehicle = request.form['vehicle']
        address = request.form['address']  # Corrected the field name
        area = request.form['area']
        taluka = request.form['taluka']
        state = request.form['state']

        # Check if the email is already in the database
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM users WHERE email = %s", (email,))
        existing_user = cur.fetchone()
        cur.close()

        if existing_user:
            # Email is not unique; handle the situation (set alert message)
            alert_message = 'Email already exists. Please choose a different email.'
            
            return render_template('register_dashboard.html', alert_message=alert_message)
            

        # Email is unique; proceed with the insertion
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO users (usertype, name, email, phone, password, confirmpassword,vehicle, address, area, taluka, state) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", 
                    (usertype, name, email, phone, password, confirmpassword, vehicle,address, area, taluka, state))
        mysql.connection.commit()
        cur.close()

        # Set success message
        alert_message = 'Registration successful!'
        return redirect(url_for('login'))

    # Render the template with the alert message
    return render_template('user_register.html', alert_message=alert_message)

@app.route('/edit_profile.html', methods=['GET', 'POST'])
def edit_profile():
    
    if 'usertype' in session and 'email' in session and 'name' in session:
        usertype = session['usertype']
        email = session['email']
        name = session['name']

        cur = mysql.connection.cursor()
        cur.execute("SELECT name, email, phone, gst, tspace, connector_types, charge_levels, dc_support, address, area, taluka, state FROM users WHERE email=%s", (email,))
        user_data = cur.fetchone()
        cur.close()

        

        if request.method == 'POST':
            # Handle form submission and update the database
            name = request.form['name']
            phone = request.form['phone']
            
            address = request.form['address']
            area = request.form['area']
            taluka = request.form['taluka']
            state = request.form['state']

            cur = mysql.connection.cursor()
            cur.execute("UPDATE users SET name=%s, phone=%s, address=%s, area=%s, taluka=%s, state=%s WHERE email=%s",
                        (name, phone, address, area, taluka, state, email))
            mysql.connection.commit()
            cur.close()

            # Redirect to the updated profile
            return redirect(url_for('edit_profile'))

        return render_template('edit_profile.html', usertype=usertype, email=email, name=name, user_data=user_data)
    else:
        return redirect(url_for('index'))


@app.route('/my_bookings.html', methods=['GET', 'POST'])
def my_bookings():
    if 'usertype' in session and 'email' in session and 'name' in session:
        usertype = session['usertype']
        email = session['email']
        name = session['name']
        date = d.today().strftime('%Y-%m-%d')
        current_time = datetime.now()
        bookingtime = current_time.strftime('%H:%M')
        
        cur = mysql.connection.cursor()
        cur.execute("SELECT `stationname`, `stationemail`, `stationphone`, `stationaddress`, `stationarea`,  `selectedport`, `selectedtype`, `selectedlevel`, `starttime`, `endtime`, `totaltime`, `totalcost`, `bookingtime`, `bookingdate` ,`st`,`id` FROM bookings WHERE useremail=%s and status=%s", (email,'Booked',))
        booking_data = cur.fetchall()
        cur.close()

        return render_template('my_bookings.html', booking_data=booking_data,usertype=usertype,email=email,name=name,bookingtime=bookingtime,date=date)
    else:
        # Redirect the user to the login page if not logged in
        return redirect(url_for('login'))

@app.route('/cancelled_bookings.html', methods=['GET', 'POST'])
def cancelled_bookings():
    if 'usertype' in session and 'email' in session and 'name' in session:
        usertype = session['usertype']
        email = session['email']
        name = session['name']
        date = d.today().strftime('%Y-%m-%d')
        current_time = datetime.now()
        one_hour_less_time = current_time - timedelta(hours=1)
        bookingtime = one_hour_less_time.strftime('%H:%M')
        
        cur = mysql.connection.cursor()
        cur.execute("SELECT `stationname`, `stationemail`, `stationphone`, `stationaddress`, `stationarea`,  `selectedport`, `selectedtype`, `selectedlevel`, `starttime`, `endtime`, `totaltime`, `totalcost`, `bookingtime`, `bookingdate` ,`st`,`id` FROM bookings WHERE useremail=%s and status=%s", (email,'Cancelled',))
        booking_data = cur.fetchall()
        cur.close()

        return render_template('cancelled_bookings.html', booking_data=booking_data,usertype=usertype,email=email,name=name,bookingtime=bookingtime,date=date)
    else:
        # Redirect the user to the login page if not logged in
        return redirect(url_for('login'))


@app.route('/cancel_booking', methods=['POST'])
def cancel_booking():
    if 'usertype' in session and 'email' in session and 'name' in session:
        if request.method == 'POST':
            booking_id = request.form['booking_id']
            # Implement cancellation logic here
            # For example, you can update the booking status in the database
            cur = mysql.connection.cursor()
            cur.execute("UPDATE bookings SET status = 'Cancelled' WHERE id = %s", (booking_id,))
            mysql.connection.commit()
            cur.close()
            flash('Booking cancelled successfully', 'success')
            return redirect(url_for('my_bookings'))
        else:
            abort(405)  # Method Not Allowed
    else:
        # Redirect the user to the login page if not logged in
        return redirect(url_for('login'))



@app.route('/complaints/<int:company_id>',methods=['GET', 'POST'])
def complaints(company_id):
    
    usertype = None
    name=None
    email=None

    cur = mysql.connection.cursor()
    cur.execute("SELECT `desc`, `u_email`, `u_name`, `date` FROM `camplaints` WHERE c_id = %s", (company_id,))
    complaints_datas = cur.fetchall()
    

    if 'usertype' in session and session['usertype'] == 'user' and 'email' in session and 'name' in session:

        usertype = session['usertype']
        email = session['email']
        name = session['name']

        if request.method == 'POST':
            # Handle form submission and update the database
            desc = request.form['desc']
            date = d.today()

            cur = mysql.connection.cursor()
            cur.execute("INSERT INTO camplaints (`c_id`, `desc`, `u_email`, `u_name`, `date`) VALUES ( %s, %s, %s, %s, %s)", 
                        (company_id,desc,email,name,date))
            mysql.connection.commit()
            cur.close()
            flash("Complain registered successfully", "success")
            
            return redirect(url_for('complaints', company_id=company_id))
            
    else:
          
        return  render_template('complaints.html',complaints_datas=complaints_datas,messages='Guess...!!You are not logged in Yet',usertype= usertype,email=email,name=name)

    
    return render_template('complaints.html',complaints_datas=complaints_datas,usertype=usertype,email=email,name=name)

@app.route('/complaints_sadmin.html')
def complaints_admin():
    usertype = None
    name = None
    email = None

    if 'usertype' in session and session['usertype'] == 'station_owner' and 'email' in session and 'name' in session:
        usertype = session['usertype']
        email = session['email']
        name = session['name']

        cur = mysql.connection.cursor()
        cur.execute("SELECT `desc`, `u_email`, `u_name`, `date` FROM `camplaints` WHERE c_id = (SELECT DISTINCT id FROM users WHERE email = %s)", (email,))
        complaints_datas = cur.fetchall()

        return render_template('complaints_sadmin.html', complaints_datas=complaints_datas, usertype=usertype, email=email, name=name)

    return render_template('login.html')

if __name__ == '__main__':
    app.run(debug=True)

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Razorpay Payment</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>
    <h1>Checkout</h1>
    <form id="payment-form" action="{{ url_for('payment') }}" method="post">
        <label for="amount">Amount (in INR):</label>
        <input type="text" name="amount" id="amount" value="{{ amount }}" readonly>
        <input type="text" name="username" value="{{ username }}" hidden>
        <input type="text" name="useremail" value="{{ useremail }}" hidden>
        <input type="text" name="userphone" value="{{ userphone }}" hidden>
        <input type="text" name="useraddress" value="{{ useraddress }}" hidden>
        <input type="text" name="userarea" value="{{ userarea }}" hidden>
        <input type="text" name="stationname" value="{{ stationname }}" hidden>
        <input type="text" name="stationemail" value="{{ stationemail }}" hidden>
        <input type="text" name="stationphone" value="{{ stationphone }}" hidden>
        <input type="text" name="stationaddress" value="{{ stationaddress }}" hidden>
        <input type="text" name="stationarea" value="{{ stationarea }}" hidden>
        <input type="text" name="selectedport" value="{{ selectedport }}" hidden>
        <input type="text" name="selectedtype" value="{{ selectedtype }}" hidden>
        <input type="text" name="selectedlevel" value="{{ selectedlevel }}" hidden>
        <input type="text" name="starttime" value="{{ starttime }}" hidden>
        <input type="text" name="endtime" value="{{ endtime }}" hidden>
        <input type="text" name="totaltime" value="{{ totaltime }}" hidden>
        <input type="text" name="totalcost" value="{{ totalcost }}" hidden>
        <input type="text" name="bookingdate" value="{{ bookingdate }}" hidden>
        <input type="text" name="bookingtime" value="{{ bookingtime }}" hidden>
        <input type="text" name="st" value="{{ st }}" hidden>
        <input type="text" name="company_id" value="{{ company_id }}" hidden>
        
        <button type="submit" id="pay">Pay with Razorpay</button>
    </form>

    <script>
        var amountField = document.getElementById('amount');
        var payButton = document.getElementById('pay');
        var razorpayKey = "rzp_test_QrXwl6OhdHsI5b"; // Replace this with your actual Razorpay API key
        // Select all hidden input elements
        // Retrieve values from input fields
        var amount = document.getElementById('amount').value;
        var username = document.getElementById('username').value;
        var useremail = document.getElementById('useremail').value;
        var userphone = document.getElementById('userphone').value;
        var useraddress = document.getElementById('useraddress').value;
        var userarea = document.getElementById('userarea').value;
        var stationname = document.getElementById('stationname').value;
        var stationemail = document.getElementById('stationemail').value;
        var stationphone = document.getElementById('stationphone').value;
        var stationaddress = document.getElementById('stationaddress').value;
        var stationarea = document.getElementById('stationarea').value;
        var selectedport = document.getElementById('selectedport').value;
        var selectedtype = document.getElementById('selectedtype').value;
        var selectedlevel = document.getElementById('selectedlevel').value;
        var starttime = document.getElementById('starttime').value;
        var endtime = document.getElementById('endtime').value;
        var totaltime = document.getElementById('totaltime').value;
        var totalcost = document.getElementById('totalcost').value;
        var bookingdate = document.getElementById('bookingdate').value;
        var bookingtime = document.getElementById('bookingtime').value;
        var st = document.getElementById('st').value;
        var company_id = document.getElementById('company_id').value;





        payButton.addEventListener('click', function(event) {
            event.preventDefault();

            var options = {
                "key": razorpayKey,
                "amount": amountField.value * 100,  // Amount is in paise
                "currency": "INR",
                "name": "Akcodes",
                "description": "Test Transaction",
                "handler": function(response) {
    window.location.href = '/success?' +
        'amount=' + amount +
        '&username=' + username +
        '&useremail=' + useremail +
        '&userphone=' + userphone +
        '&useraddress=' + useraddress +
        '&userarea=' + userarea +
        '&stationname=' + stationname +
        '&stationemail=' + stationemail +
        '&stationphone=' + stationphone +
        '&stationaddress=' + stationaddress +
        '&stationarea=' + stationarea +
        '&selectedport=' + selectedport +
        '&selectedtype=' + selectedtype +
        '&selectedlevel=' + selectedlevel +
        '&starttime=' + starttime +
        '&endtime=' + endtime +
        '&totaltime=' + totaltime +
        '&totalcost=' + totalcost +
        '&bookingdate=' + bookingdate +
        '&bookingtime=' + bookingtime +
        '&st=' + st +
        '&company_id=' + company_id;
},


                "prefill": {
                    "name": "Ayush Gupta",
                    "email": "gayush2041@gmail.com"
                },
                "notes": {
                    "address": "Razorpay Corporate Office"
                },
                "theme": {
                    "color": "#F37254"
                }
            };

            console.log(options); // Log options to check if they are correct

            var rzp = new Razorpay(options);
            rzp.open();
        }); 
    </script>
</body>
</html>
