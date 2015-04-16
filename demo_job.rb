require "json"

# All the example tiles use the same data
# Note that the first nested array ["Person", "Tickets"] denotes the data column names used
#   internally by Google Charts. You must include this or weird stuff will happen. 
data = [["Person", "Tickets"], ["Bob", 52], ["Frank", 83], ["Jane", 57], ["Mary", 60]]

# Notice the .to_json called on the data. This is important!
send_event("google_charts_demo", data: data.to_json)
