package tl.viewController{	import flash.display.DisplayObject;	import flash.display.DisplayObjectContainer;	import tl.view.IViewContainer;	public class SingleViewController extends ViewController implements ISingleViewController	{		[Outlet]		public var container : DisplayObjectContainer;		private var _currentViewController : IVIewController;		override public function getViewInterface() : Class		{			return IViewContainer;		}		public function set currentViewController( value : IVIewController ) : void		{			if ( value == _currentViewController )			{				return;			}			var viewElement : DisplayObject;			if ( _currentViewController )			{				if ( _currentViewController.viewIsLoaded )				{					viewElement = _currentViewController.view as DisplayObject;					_currentViewController.viewBeforeRemovedFromStage();					if ( viewElement.parent )					{						viewElement.parent.removeChild( viewElement );					}				}				_currentViewController.parentViewController = null;			}			while ( container.numChildren )			{				container.removeChildAt( 0 );			}			value.parentViewController = this;			viewElement = value.view as DisplayObject;			value.viewBeforeAddedToStage();			container.addChild( viewElement );			_currentViewController = value;		}		public function get currentViewController() : IVIewController		{			return _currentViewController;		}	}}