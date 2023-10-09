import mysql.connector


conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='8112001',
    database='route'
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

def get_routes():
    conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='8112001',
    database='route'
)
    cursor.execute("SELECT * FROM ways")
    ways = cursor.fetchall()
    routes = {}

    for ways_id,name in ways:
        cursor.execute(f"SELECT * FROM routes WHERE ways_id = {ways_id}")
        routes[name] = cursor.fetchall()
    conn.close()
    return routes

def main():
    start_city = "Pune"
    end_city = "Delhi"

    routes = get_routes()
    graph = {}
    for ways_id, route in routes.items():
        for Pune, Delhi, distance in route:
            if Pune not in graph:
                graph[Pune] = []
            if Delhi not in graph:
                graph[Delhi] = []
            graph[Pune].append((Delhi, distance))
            graph[Delhi].append((Pune, distance))
        if start_city in graph and end_city in graph:
            path, distance = dijkstra(graph, start_city, end_city)
            print(f"Optimal Path from {start_city} to {end_city}:")
            print(path)
            print(f"Total Distance: {distance}")
        else:
            print("Invalid cities provided.")
    
if __name__ == "__main__":
    main()

cursor.close()




