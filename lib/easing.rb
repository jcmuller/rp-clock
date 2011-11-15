# Robert Penner easing equations
# BSD

module Easing
  # c = time/frame
  # b = base
  # c = target
  # d = duration

  def get_easings
    [
      :linearTween,
      :easeInQuad,
      :easeOutQuad,
      :easeInOutQuad,
      :easeInCubic,
      :easeOutCubic,
      :easeInOutCubic,
      :easeInQuart,
      :easeOutQuart,
      :easeInOutQuart,
      :easeInQuint,
      :easeOutQuint,
      :easeInOutQuint,
      :easeInSine,
      :easeOutSine,
      :easeInOutSine,
      :easeInExpo,
      :easeOutExpo,
      :easeInOutExpo,
      :easeInCirc,
      :easeOutCirc,
      :easeInOutCirc
    ]
  end

  def linearTween(t, b, c, d)
    return c * t / d + b
  end

  # quadratic easing in - accelerating from zero velocity
  def easeInQuad(t, b, c, d)
    t /= d
    c * t * t + b
  end

  # quadratic easing out - decelerating to zero velocity
  def easeOutQuad(t, b, c, d)
    t /= d
    - c * t * (t - 2) + b
  end

  # quadratic easing in/out - acceleration until halfway, then deceleration
  def easeInOutQuad(t, b, c, d)
    t /= d / 2
    return c / 2 * t * t + b if (t < 1)
    t -= 1
    -c / 2 * (t * (t - 2) - 1) + b
  end

  # cubic easing in - accelerating from zero velocity
  def easeInCubic(t, b, c, d)
    t /= d
    c * t * t * t + b
  end

  # cubic easing out - decelerating to zero velocity
  def easeOutCubic(t, b, c, d)
    t /= d
    t -= 1
    c * (t * t * t + 1) + b
  end

  # cubic easing in/out - acceleration until halfway, then deceleration
  def easeInOutCubic(t, b, c, d)
    t /= d / 2
    return c / 2 * t * t * t + b if (t < 1)
    t -= 2
    c / 2 * (t * t * t + 2) + b
  end

  # quartic easing in - accelerating from zero velocity
  def easeInQuart(t, b, c, d)
    t /= d
    c * t * t * t * t + b
  end

  # quartic easing out - decelerating to zero velocity
  def easeOutQuart(t, b, c, d)
    t /= d
    t -= 1
    -c * (t * t * t * t - 1) + b
  end

  # quartic easing in/out - acceleration until halfway, then deceleration
  def easeInOutQuart(t, b, c, d)
    t /= d / 2
    return c / 2 * t * t * t * t + b if (t < 1)
    t -= 2
    -c / 2 * (t * t * t * t - 2) + b
  end

  # quintic easing in - accelerating from zero velocity
  def easeInQuint(t, b, c, d)
    t /= d
    c * t * t * t * t * t + b
  end

  # quintic easing out - decelerating to zero velocity
  def easeOutQuint(t, b, c, d)
    t /= d
    t -= 1
    c * (t * t * t * t * t + 1) + b
  end

  # quintic easing in/out - acceleration until halfway, then deceleration
  def easeInOutQuint(t, b, c, d)
    t /= d / 2
    return c / 2 * t * t * t * t * t + b if (t < 1)
    t -= 2
    c / 2 * (t * t * t * t * t + 2) + b
  end

  # sinusoidal easing in - accelerating from zero velocity
  def easeInSine(t, b, c, d)
    -c * Math.cos(t / d * (Math::PI / 2)) + c + b
  end

  # sinusoidal easing out - decelerating to zero velocity
  def easeOutSine(t, b, c, d)
    c * Math.sin(t / d * (Math::PI / 2)) + b
  end

  # sinusoidal easing in/out - accelerating until halfway, then decelerating
  def easeInOutSine(t, b, c, d)
    -c / 2 * (Math.cos(Math::PI * t / d) - 1) + b
  end

  # exponential easing in - accelerating from zero velocity
  def easeInExpo(t, b, c, d)
    c * ( 2 ** (10 * (t / d - 1)) ) + b
  end

  # exponential easing out - decelerating to zero velocity
  def easeOutExpo(t, b, c, d)
    c * (-(2 ** (-10 * t / d)) + 1) + b
  end

  # exponential easing in/out - accelerating until halfway, then decelerating
  def easeInOutExpo(t, b, c, d)
    t /= d / 2
    return c / 2 * (2 ** (10 * (t - 1))) + b if (t < 1)
    t -= 1
    c / 2 * (-(2 ** (-10 * t)) + 2) + b
  end

  # circular easing in - accelerating from zero velocity
  def easeInCirc(t, b, c, d)
    t /= d
    -c * (Math.sqrt(1 - t * t) - 1) + b
  end

  # circular easing out - decelerating to zero velocity
  def easeOutCirc(t, b, c, d)
    t /= d
    t -= 1
    c * Math.sqrt(1 - t * t) + b
  end

  # circular easing in/out - acceleration until halfway, then deceleration
  def easeInOutCirc(t, b, c, d)
    t /= d / 2
    return -c / 2 * (Math.sqrt(1 - t * t) - 1) + b if (t < 1)
    t -= 2
    c / 2 * (Math.sqrt(1 - t * t) + 1) + b
  end
end
