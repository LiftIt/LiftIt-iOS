class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @routines_controller = RoutinesController.alloc.initWithNibName(nil, bundle:nil)
    @navigation_controller = UINavigationController.alloc.initWithRootViewController(@routines_controller)

    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible

    true
  end
end
