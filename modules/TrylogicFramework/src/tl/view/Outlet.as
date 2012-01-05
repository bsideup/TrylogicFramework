package tl.view{	import flash.display.DisplayObject;	import flash.events.IEventDispatcher;	import flash.utils.flash_proxy;	import mx.utils.ObjectProxy;	import mx.utils.object_proxy;	use namespace flash_proxy;	use namespace object_proxy;	[Event(name="mouseDown", type="flash.events.MouseEvent")]	public dynamic class Outlet extends ObjectProxy implements IEventDispatcher	{		private var changedProperties : Object = {};		private var eventsInterests : Array = [];		object_proxy function get outletObject() : DisplayObject		{			return super.object as DisplayObject;		}		public function set instance( value : DisplayObject ) : void		{			var interest : String;			if ( outletObject )			{				for each( interest in eventsInterests )				{					outletObject.removeEventListener( interest, dispatcher.dispatchEvent );				}			}			if ( value != null )			{				for ( var prop : String in changedProperties )				{					value[prop] = changedProperties[prop];				}				for each( interest in eventsInterests )				{					value.addEventListener( interest, dispatcher.dispatchEvent, false, 0, true );				}			}			super.readExternal( new SimpleInput( value == null ? {} : value ) );		}		override flash_proxy function setProperty( name : *, value : * ) : void		{			changedProperties[name] = value;			super.setProperty( name, value );		}		override flash_proxy function getProperty( name : * ) : *		{			if ( name == "constructor" )			{				return Outlet;			}			else			{				return super.getProperty( name );			}		}		override flash_proxy function deleteProperty( name : * ) : Boolean		{			delete changedProperties[name];			return super.deleteProperty( name );		}		override public function addEventListener( type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false ) : void		{			if ( !(type in eventsInterests) )			{				eventsInterests.push( type );				if ( outletObject )				{					outletObject.addEventListener( type, dispatcher.dispatchEvent, false, 0, true );				}			}			super.addEventListener( type, listener, useCapture, priority, useWeakReference );		}		override public function removeEventListener( type : String, listener : Function, useCapture : Boolean = false ) : void		{			if ( type in eventsInterests )			{				eventsInterests.splice( eventsInterests.indexOf( type ), 1 );				if ( outletObject )				{					outletObject.removeEventListener( type, dispatcher.dispatchEvent );				}			}			super.removeEventListener( type, listener, useCapture );		}	}}import flash.utils.ByteArray;class SimpleInput extends ByteArray{	private var value : *;	public function SimpleInput( value : * )	{		this.value = value;	}	override public function readObject() : *	{		return value;	}}