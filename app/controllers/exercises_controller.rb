class ExercisesController < UIViewController
  attr_accessor :routine
  attr_accessor :delegate

  def viewDidLoad
    super

    self.title = routine["name"]

    @data = routine["exercises"]
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
    name = exercise[:name]
    sets = exercise[:sets]
    reps = exercise[:reps]

    title = "#{exercise[:name]} (#{exercise[:sets]}x"

    if reps.is_a?(Array)
      title = "#{title}...)"
    else
      title = "#{title}#{exercise[:reps]})"
    end

    title = "#{title} #{exercise[:rest]}\""

    cell.textLabel.text = title
    cell
  end
end
