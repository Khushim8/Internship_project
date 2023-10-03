import mysql.connector

# Establish the connection
conn = mysql.connector.connect(
    host='your_host',       # Replace with your MySQL host
    user='your_username',   # Replace with your MySQL username
    password='your_password',  # Replace with your MySQL password
    database='your_database'  # Replace with your MySQL database name
)

# Create a cursor object to execute SQL queries
cursor = conn.cursor()

# Execute a sample query
cursor.execute("SELECT * FROM Main")

# Fetch the result
result = cursor.fetchall()

# Print the result
for row in result:
    print(row)

# Close the cursor and connection
cursor.close()
conn.close()
