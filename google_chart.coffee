class Dashing.GoogleChart extends Dashing.Widget

  ready: ->
    node = $(@node)
    chart_target = node.find("#graph")[0]
    chart_div = $(chart_target)
    @options = chart_div.attr("options")
    @font_size = parseInt(chart_div.css("font-size"))
    @height = node.height()
    @width = node.width()
    @background_color = node.css("background-color")
    @chart_type = chart_div.attr("charttype")
    
    @chart = new google.visualization[@chart_type](chart_target)
    
    
    header_height = 1.5 * @font_size
    footer_height = @font_size
    yaxis_label_width = 2 * @font_size
    xaxis_label_height = 4 * @font_size
    
    
    # Default chart options
    default_options = {
      'bar': { 
        'groupWidth': '92%' 
      },
      'fontSize': @font_size,
      'colors': ['#fff'],
      'width': @width,
      'height': @height - header_height - footer_height,
      'backgroundColor': @background_color,
      'chartArea': {
        'left': yaxis_label_width,
        'width': @width,
        'height': @height - header_height - xaxis_label_height,
        'backgroundColor': @background_color
      },
      'hAxis': {
        'maxAlternation': 1,
        'format': '#,###',
        'textPosition': 'out',
        'baselineColor': @background_color,
        'baseline': -3,
        'textStyle': {
          'color': '#fff'
        },
        'gridlines':{
          'color': @background_color
        }
      },
      'vAxis': {
        'textPosition': 'out',
        'baselineColor': @background_color,
        'textStyle': {
          'color': '#fff'
        }
      },
      'legend': {
        'position': 'none'
      }
    }
    
    # Add some padding for AreaCharts
    if @chart_type == 'AreaChart'
      default_options["chartArea"]["height"] = default_options["chartArea"]["height"] - 15
    
    # Separate configuration for Bar Chats. Not done yet.
    if @chart_type == 'BarChart'
      yaxis_label_width = 16 * @font_size
    
      default_options = {
        'bar': { 
          'groupWidth': '92%' 
        },
        'fontSize': @font_size,
        'colors': ['#fff'],
        'width': @width,
        'height': @height - header_height - footer_height,
        'backgroundColor': @background_color,
        'chartArea': {
          'left': yaxis_label_width * 2 / 3,
          'width': (@width - yaxis_label_width) * 5 / 4,
          'height': @height - header_height - xaxis_label_height,
          'backgroundColor': @background_color
        },
        'hAxis': {
          'minValue': 0,
          'maxAlternation': 1,
          'format': '#,###',
          'textPosition': 'out',
          'baselineColor': @background_color,
          'textStyle': {
            'color': '#fff'
          },
          'gridlines':{
            'color': @background_color
          }
        },
        'vAxis': {
          'textPosition': 'out',
          'baselineColor': @background_color,
          'textStyle': {
            'color': '#fff'
          }
        },
        'legend': {
          'position': 'none'
        }
      }
      
      
      yaxis_label_width = 0
      default_options = {
        'bar': { 
          'groupWidth': '92%' 
        },
        'fontSize': @font_size,
        'colors': ['#fff'],
        'width': @width,
        'height': @height - header_height - footer_height,
        'backgroundColor': @background_color,
        'chartArea': {
          'left': @font_size,
          'width': @width,
          'height': @height - header_height - xaxis_label_height,
          'backgroundColor': @background_color
        },
        'hAxis': {
          'format': '#,###',
          'textPosition': 'out',
          'baselineColor': @background_color,
          'textStyle': {
            'color': '#fff'
          },
          'gridlines':{
            'color': @background_color
          }
        },
        'vAxis': {
          'textPosition': 'in',
          'baselineColor': @background_color,
          'textStyle': {
            'color': '#ddd'
          }
        },
        'legend': {
          'position': 'none'
        }
      }
      
    
    
    # Use different config set for PieCharts
    # The default is to have a pie chart on top and legend beneath it.
    if @chart_type == 'PieChart'
      legend_target = node.find("#legend")[0]
      @legend = new google.visualization[@chart_type](legend_target)
      legend_height = 4 * @font_size
      # Maybe use css for this with a class bound to the charttype?
      top_padding = 20
      header_height = 1 * @font_size

      # Pie chart options
      default_options = {
        'fontSize': @font_size,
        'pieSliceText': 'value',
        'width': @width,
        'height': @height - header_height - footer_height - legend_height,
        'backgroundColor': @background_color,
        'chartArea': {
          'width': @width,
          'height': @height - header_height - footer_height - legend_height,
          'backgroundColor': @background_color
          'top': top_padding,
        },
        'legend': {
          'position': 'none',
        }
      }

      # Legend options
      @legend_options = {
        'width': @width,
        'height': 3 * 15,
        #'height': legend_height,
        'backgroundColor': @background_color,
        'chartArea': {
          'width': @width,
          'top': legend_height,
          'backgroundColor': @background_color
        },
        'legend': {
          'position': 'top',
          'maxLines': 2,
          'alignment': 'start',
          'textStyle': {
            'color': '#eee',
            'fontSize': 15
          }
        }
      }
    
    # Add user-specified options to defaults, overriding if necessary
    if @options != 'undefined'
      @options = JSON.parse(@options.substring(1))
      $.extend(true, default_options, @options)
    @options = default_options
    
    data = $(chart_div).attr("data")
    if data != 'undefined'
      @drawChart(data)


  onData: (data) ->
    @drawChart(data.data)


  drawChart: (data) ->
    data = JSON.parse(data)
    chartData = new google.visualization.arrayToDataTable(data)
    @chart.draw(chartData, @options)
    if @chart_type == 'PieChart'
      @legend.draw(chartData, @legend_options);
      
    