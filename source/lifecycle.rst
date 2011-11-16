Components Lifecycle
==========================


ViewController
--------------------------------------

**viewLoaded**
  On this step Outlets are ready to use, but view IS NOT added to stage yet. 
  Good place to setup initial values for outlets, stop MovieClip’s etc.
**viewBeforeAddedToStage**
  Called just before ``addChild(controller.view)``. 
  Good place to add some components to View or other ViewControllers (if you extends ViewControllerContainer)
**[Event] addedToStage**
  Just view’s Event.ADDED_TO_STAGE handler
**viewBeforeRemovedFromStage**
  Called just before ``removeChild(controller.view)``.
  Good place to clean-up view for removing from stage.
**[Event] removedFromStage**
  Just view’s Event.REMOVED_FROM_STAGE handler
**destroy/internalDestroy**
  Destructor for ViewController. Clean up everything you have in your ViewController. Used for GC.