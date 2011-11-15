require 'lib/easing'

class Clock < Processing::App
  load_library :control_panel

  include Easing

  attr_accessor :app_size, :fps

  def setup
    @app_size = 150
    reset!
    #setting up a variable, since this is never exact
    @fps = 60
    frame_rate fps
    color_mode HSB, 1.0
    stroke_cap ROUND
    smooth
    @count = 0
    @easings = get_easings
    cycle_easing
  end

  def reset!
    size(app_size, app_size)
    frame.set_size(app_size - 10, app_size + 10)
    @radius = width/2.0 * 0.8
  end

  def load_menu_item(m)
  end

  def draw
    background(1, 0)
    draw_marks
    render_sections hour % 12, minute, second

    if @s != second
      @count = -1
      @s = second
    end

    @count += 1
    draw_center
  end

  def render_sections h, m, s
    stroke_weight 5
    render_section @radius * 3 / 5.0, h, 12, m, 60
    render_section @radius * 0.8, m, 60, s, 60

    stroke_weight 1
    render_section @radius * 0.9, s, 60, @count, fps
  end

  def stroke_color r
    stroke(r.to_f / @radius.to_f, 1, 0.75)
  end

  def draw_marks
    no_stroke
    stroke 0.4, 0.4, 0.4
    stroke_weight 1
    draw_marks_for_radius @radius, 60, 5
    stroke_weight 2.0
    draw_marks_for_radius @radius, 12
    no_stroke
  end

  def draw_center
    no_stroke
    fill 0.2, 0.2, 0.2
    ellipse width/2.0, height/2.0, 10, 10
  end

  def draw_marks_for_radius r, total, size = 10
    (0...total).each do |value|
      alpha = 360.0 / total.to_f * value.to_f
      a = (90 - alpha).to_f * Math::PI / 180.0
      x = width / 2.0 + r * Math.cos(a)
      y = height / 2.0 - r * Math.sin(a)

      x1 =  width / 2.0 + (r - size) * Math.cos(a)
      y1 = height / 2.0 - (r - size) * Math.sin(a)
      line x1, y1, x, y
    end
  end

  def render_section r, s, max, other = 0, other_max = 1
    stroke_color r
    base_angle = -Math::PI / 2.0

    a = easing(other.to_f, 0.0, other.to_f / other_max.to_f, other_max.to_f)
    angle = (s.to_f / max.to_f) * Math::PI * 2.0 + a * 2.0 * Math::PI / max.to_f
    #angle  = (s.to_f / max.to_f) * Math::PI * 2.0 + other.to_f / other_max.to_f * 2.0 * Math::PI / max.to_f

    x = width/2.0
    y = height/2.0
    x1 = x + r * Math.cos(angle + base_angle)
    y1 = y + r * Math.sin(angle + base_angle)

    line x, y, x1, y1
  end

  def easing *args
    send @current_easing, *args
  end

  def key_released
    case key
    when CODED
      case key_code
      when UP
        puts "UP"
        cycle_easing
      when DOWN
        puts "DOWN"
        cycle_easing_back
      end
    when 'p'
      show_control_panel
    end
  end

  def mouse_released
    if mouse_button == RIGHT
      show_control_panel
    end
  end

  def show_control_panel
    unless @control_panel
      @control_panel = ControlPanel::Panel.new
      control_panel.slider(:app_size, 100..600, 150) { reset! }
    end

    control_panel.display
  end

  def cycle_easing
    @current_easing = @easings.shift
    @easings << @current_easing
    puts "Current Easing: #{@current_easing}"
  end

  def cycle_easing_back
    @easings.unshift(@current_easing)
    @current_easing = @easings.pop
    puts "Current Easing: #{@current_easing}"
  end
end
