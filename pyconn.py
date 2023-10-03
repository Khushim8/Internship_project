import mysql.connector

# Replace these with your actual database credentials
db_config = {
    "host": "your_host",
    "user": "your_username",
    "password": "your_password",
    "database": "your_database_name"
}

# Connect to the database
conn = mysql.connector.connect(**db_config)

# Create a cursor object to interact with the database
cursor = conn.cursor()

# Prompt the user for input
from_city = input("Enter the departure city: ")
to_city = input("Enter the arrival city: ")
departure_time = input("Enter the departure time: ")
arrival_time = input("Enter the arrival time: ")

# Initialize variables for your custom logic
to = to_city
prev_to = from_city
result_array = []

while prev_to != to:
    # Select arrival and to values based on your conditions
    select_query = """
    SELECT arrival, `to`
    FROM your_table_name
    WHERE departure > %s AND `from` = %s
    """

    cursor.execute(select_query, (departure_time, prev_to))

    row = cursor.fetchone()

    if row:
        prev_arrival, prev_to = row
        result_array.append({"arrival": prev_arrival, "to": prev_to})
    else:
        break

# Display the result array
if result_array:
    print("Matching travel plans:")
    for row in result_array:
        print(row)
else:
    print("No matching travel plans found.")

# Close the cursor and connection when done
cursor.close()
conn.close()
