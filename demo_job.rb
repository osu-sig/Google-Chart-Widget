require "json"

# All the example tiles use the same data
data = [["Person", "Tickets"], ["Bob", 52], ["Frank", 83], ["Jane", 57], ["Mary", 60]]

# Notice the .to_json called on the data. This is important!
send_event("google_charts_demo", data: data.to_json)
