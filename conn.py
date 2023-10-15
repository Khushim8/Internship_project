import mysql.connector

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='8112001',
    database='db'
)
cursor = conn.cursor()
table_name = 'ways'
cursor.execute(f'SELECT COUNT(*) FROM {table_name}')
num_rows = cursor.fetchone()[0]
print("Number of rows are:" , num_rows)


def dijkstra(graph, start, end):
    visited = {node: False for node in graph}
    distances = {node: float('infinity') for node in graph}
    previous_nodes = {node: None for node in graph}
    distances[start] = 0

    while True:
        min_node = None
        for node in graph:
            if not visited[node] and (min_node is None or distances[node] < distances[min_node]):
                min_node = node

        if min_node is None or distances[min_node] == float('infinity'):
            break

        visited[min_node] = True

        for neighbor, weight in graph[min_node]:
            potential_distance = distances[min_node] + weight
            if potential_distance < distances[neighbor]:
                distances[neighbor] = potential_distance
                previous_nodes[neighbor] = min_node

    path = []
    while end is not None:
        path.append(end)
        end = previous_nodes[end]

    return path[::-1], distances[path[-1]]

# def get_routes(cursor):
#     routes = {}
    
#     # Fetch all distinct ways from the 'ways' table
#     cursor.execute("SELECT DISTINCT Ways_ID FROM ways")
#     ways_data = cursor.fetchall()

#     #for Ways_ID in ways:
#     for Ways_ID in ways_data:
#         cursor.execute(f"SELECT From_City_ID, To_City_ID, distance FROM newmain WHERE way_id = {Ways_ID}")
#         route_data = cursor.fetchall()

#     routes[Ways_ID] = [(From_City_ID, To_City_ID, distance) for From_City_ID, To_City_ID, distance in route_data]
#     print(routes);
#     return routes
def get_routes(cursor):
    routes = {}
    
    # Fetch all distinct ways from the 'ways' table
    cursor.execute("SELECT DISTINCT Ways_ID FROM ways")
    ways_data = cursor.fetchall()

    for Ways_ID in ways_data:
        cursor.execute(f"SELECT From_City_ID, To_City_ID, distance FROM newmain WHERE way_id = {Ways_ID[0]}")
        route_data = cursor.fetchall()

        routes[Ways_ID[0]] = [(From_City_ID, To_City_ID, distance) for From_City_ID, To_City_ID, distance in route_data]

    print(routes)
    return routes

def main():
    start_city = 2  # Assuming you want to use city IDs instead of names (e.g., Pune's ID)
    end_city = 3    # Change these IDs based on your specific city data (e.g., Delhi's ID)

    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='8112001',
        database='db'  # Use the 'db' database
    )
    cursor = conn.cursor()

    routes = get_routes(cursor)
    graph = {}
    for ways_id, route in routes.items():
        for From_City_ID, To_City_ID, distance in route:
            if From_City_ID not in graph:
                graph[From_City_ID] = []
            if To_City_ID not in graph:
                graph[To_City_ID] = []
            graph[From_City_ID].append((To_City_ID, distance))
            graph[To_City_ID].append((From_City_ID, distance))

    if start_city in graph and end_city in graph:
        path, distance = dijkstra(graph, start_city, end_city)
        print(f"Optimal Path from {start_city} to {end_city}:")
        print(path)
        print(f"Total Distance: {distance}")
    else:
        print("Invalid city IDs provided.")

    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()