class ExercisesController < UIViewController
  attr_accessor :routine

  def viewDidLoad
    super

    self.title = routine.name

    @data = routine.exercises
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    self.view.addSubview @table

    @table.dataSource = self
    @table.delegate = self
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    exercise = @data[indexPath.row]

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell.textLabel.text = exercise.label
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    exercise = ExerciseController.alloc.init
    exercise.exercise = @data[indexPath.row]
    self.navigationController.pushViewController(exercise, animated:true)
  end
end
