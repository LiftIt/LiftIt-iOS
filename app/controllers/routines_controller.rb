class RoutinesController < UIViewController
  def viewDidLoad
    super

    self.title = 'Routines'

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    self.view.addSubview @table

    @table.dataSource = self
    @table.delegate = self

    reload_button = UIBarButtonItem.alloc.initWithTitle("Reload",
        style: UIBarButtonItemStyleBordered, target:self, action:'reload')
    self.navigationItem.rightBarButtonItem = reload_button

    @data = []
    reload
  end

  def reload
    Routine.all do |routines|
      puts "reload:"
      p routines
      @data = routines
      @table.reloadData
    end
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell.textLabel.text = @data[indexPath.row].name
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    exercises = ExercisesController.alloc.init
    exercises.routine = @data[indexPath.row]
    self.navigationController.pushViewController(exercises, animated:true)
  end
end
