class ExerciseController < UIViewController
  attr_accessor :exercise
  attr_accessor :delegate

  def loadView
    self.view = ExerciseView.alloc.initWithFrame(CGRectZero)
    self.view.delegate = self
    self.view.exercise = exercise
    self.view.refresh
  end

  def viewDidLoad
    super
    self.title = exercise.name
  end

  def timer_button_tapped(sender)
    self.view.timer_button_tapped(sender)
  end

  def routine_finished
    self.delegate.routine_finished
  end

end
