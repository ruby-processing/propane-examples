require 'propane'

class BarChartSketch < Propane::App
  # Sketch to demonstrate the use of the BarChart class to draw simple bar charts.
  # Version 1.3, 6th February, 2016.
  # Author Jo Wood, giCentre.

  load_library :gicenter_utils
  include_package 'org.gicentre.utils.stat' # British spelling

  def settings
    size(800, 300)
    smooth
  end

  def setup # a static sketch no need for draw loop
    sketch_title 'Bar Chart Sketch'
    title_font = load_font(data_path('Helvetica-22.vlw'))
    small_font = load_font(data_path('Helvetica-12.vlw'))
    text_font(small_font)
    bar_chart = BarChart.new(self)
    data_float = [
      2_462, 2_801, 3_280, 3_983, 4_490, 4_894, 5_642, 6_322, 6_489, 6_401, 
      7_657, 9_649, 9_767, 12_167, 15_154, 18_200, 23_124, 28_645, 39_471
    ]
    bar_chart.setData(data_float.to_java(:float))
    data_label = %w(1830 1840 1850 1860 1870 1880 1890 1900 1910 1920 1930 1940 1950 1960 1970 1980 1990 2000 2010)
    bar_chart.setBarLabels(data_label)
    bar_chart.setBarColour(color(200, 80, 80, 100))
    bar_chart.setBarGap(2)
    bar_chart.setValueFormat('$###,###')
    bar_chart.showValueAxis(true)
    bar_chart.showCategoryAxis(true)
    background(255)
    bar_chart.draw(10, 10, width - 20, height - 20)
    fill(120)
    text_font(title_font)
    text('Income per person, United Kingdom', 70, 30)
    text_height = text_ascent # of title font
    text_font(small_font)
    text('Gross domestic product measured in inflation-corrected $US', 70, 30 + text_height)
  end
end

BarChartSketch.new
