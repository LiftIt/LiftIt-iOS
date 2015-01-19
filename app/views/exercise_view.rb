class ExerciseView < UIView
  include BubbleWrap::KVO

  attr_accessor :delegate
  attr_accessor :exercise
  attr_accessor :current_set

  def initWithFrame(frame)
    super.tap do
      self.styleId = 'exercise_view'

      Motion::Layout.new do |layout|
        layout.view(self)
        layout.subviews(
          name: name_label,
          reps: reps_label,
          current: current_label,
          timer: timer_label,
          button: timer_button
        )
        layout.metrics margin: 20
        layout.vertical "|-80-[name]-10-[reps]-60-[current]-60-[timer]-(>=80)-|"
        layout.vertical "|-[button(==60)]-40-|"
        layout.horizontal "|-margin-[name]-margin-|"
        layout.horizontal "|-margin-[reps]-margin-|"
        layout.horizontal "|-margin-[current]-margin-|"
        layout.horizontal "|-margin-[timer]-margin-|"
        layout.horizontal "|-margin-[button]-margin-|"
      end
    end
  end

  def start_next
    puts "*** Start next"
    timer_button.setTitle('Descansar', forState: UIControlStateNormal)
    timer_counter.pause
    timer_counter.reset
    timer_counter.setCountDownTime(exercise.rest)
    exercise.start
  end

  def start_rest
    exercise.finish
    timer_button.setTitle('Iniciar Próximo', forState: UIControlStateNormal)
    timer_counter.start
  end

  def timer_button_tapped(sender)
    puts "Exercise status = #{exercise.status}"
    if exercise.started?
      start_rest
    else
      next_ex = start_next
      puts "self = #{self.exercise}"
      puts "next = #{next_ex}"

      return finish_routine unless next_ex

      if next_ex != self.exercise
        self.exercise = next_ex
        self.refresh
      end
    end
  end

  def finish_routine
    App.alert('Treino finalizado!')
  end

  def timerLabel(timerLabel, finshedCountDownTimerWithTime:countTime)
    local_file = NSURL.fileURLWithPath(File.join(NSBundle.mainBundle.resourcePath, 'alert1.mp3'))
    BW::Media.play(local_file) do |media_player|
      media_player.view.frame = [[10, 100], [100, 100]]
      media_player.view.alpha = 0.0
      self.addSubview(media_player.view)
    end
    start_next
  end

  def refresh
    puts "*** Refresh"
    timer_counter.setCountDownTime(exercise.rest)
    timer_counter.timeFormat = "mm:ss.SS"
    timer_counter.delegate = self

    name_label.text = exercise.name
    reps_label.text = exercise.reps_label

    observe(self.exercise, "current_set") do |old_value, new_value|
      current_label.text = "#{exercise.current_set} de #{exercise.sets}"
    end

    puts "*** Exercise start"
    exercise.start
  end

  def name_label
    @name_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleId = 'name_label'
    end
  end

  def reps_label
    @reps_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleId = 'reps_label'
    end
  end

  def current_label
    @current_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleId = 'current_label'
    end
  end

  def timer_label
    @timer_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleId = 'timer_label'
      label.text = '00:00'
    end
  end

  def timer_counter
    @timer_counter ||= MZTimerLabel.alloc.initWithLabel(@timer_label, andTimerType:MZTimerLabelTypeTimer)
  end

  def timer_button
    @timer_button ||= UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      button.styleId = 'timer_button'
      button.setTitle('Descansar', forState: UIControlStateNormal)
      button.setTitle('Iniciar Próximo' , forState: UIControlStateSelected)
      button.addTarget(nextResponder, action: 'timer_button_tapped:',
        forControlEvents: UIControlEventTouchUpInside)
    end
  end
end
