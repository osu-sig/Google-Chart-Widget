---
title: Google Chart
description: Google Charts shrunk into widget form
author: Michael Woffendin
tags:  widget, dashing, chart, google, graph, bar, area, pie
created:  2015 April 16
modified: 2015 April 16

---

Google Chart
=========

![alt tag](https://raw.github.com/osu-sig/Google-Chart-Widget/master/screenshot.png)

## What is it?

The Google Charts widget is, as the name implies, Google Charts in widget form. It has all the same customization options and capabilities as Google Charts. 


## What charts are supported?

This widget currently supports the Pie, Column, and Area chart types. For these types, I have supplied default configurations that resize chart elements to fit nicely on standard Dashing tiles.


## How do I use it?

See demo job and dashboard for examples. In the job, you send formatted JSON data to your desired dashboard tiles. In the dashboard, you specify what kind of chart a given tile should be by setting  the 'data-charttype' html attribute to either 'ColumnChart', 'PieChart', or 'AreaChart' (data-charttype='ColumnChart'). That's it!


## How do I customize my chart?

All options supported by Google Charts are also supported by this widget. See the last tile on the demo dashboard for an example. On the tile you wish to customize, set the 'data-options' html attribute to a JSON attribute string (data-options='/{"colors": ["#ccc"]}'). PLEASE NOTE the following about the options:
* Your JSON string MUST start with a / before the opening {. Otherwise it will not parse correctly. This happens because Dashing automatically parses valid JSON attributes, making them unreadable for the widget. The / invalidates the JSON string and prevents this from happening. 
* Your JSON string MUST use single quotes ' for the outermost quotations and double quotes " for inner quotations. Otherwise it will not parse correctly.

