package com.trdevt.util 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.osflash.signals.Signal;
	/**
	 * similar to the shared object, this class will act as a library of static values that were loaded from an xml file. the scope will be public for these "static" values
	 * 
	 * @author Jake
	 */
	public class XMLManager 
	{
		/**
		 * public signal for when the xml has finished loading
		 */
		public var signalLoadCompleted:Signal;
		
		/**
		 * helper loader
		 */
		private var _urlLoader:URLLoader
		
		/**
		 * true while the xml is still loading
		 */
		private var _bIsLoading:Boolean;
		
		/**
		 * the instance of the xml object
		 */
		private var _xmlConfig:XML=null;
		
		/**
		 * the instance of the singleton XMLManager, starts off null, but will be created later
		 */
		private static const _instance			:XMLManager = new XMLManager( SingletonLock );
		
		/**
		 * the name of the XMLManager
		 */
		private var _sLSOName:String;
				
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * creates the singleton XMLManager, should never be called directly! Call init() instead
		 */
		public function XMLManager($lock:Class) 
		{
			if ($lock != SingletonLock)
				throw new Error("XMLManager is a singleton and should not be instantiated. Use XMLManager.instance instead");
				
			signalLoadCompleted = new Signal();
				
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * creates the single instance of the XMLManager.
		 * @param	$sPath the path to the config file
		 */
		public function init($sPath:String):void 
		{			
			_bIsLoading = true;
			
			
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, loadComplete);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			
			_urlLoader.load(new URLRequest($sPath));
			trace("loading xml... ");
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * gets called when xml is done loading
		 */
		private function loadComplete($event:Event = null):void 
		{			
			_xmlConfig = new XML(_urlLoader.data);
			
			initializeStaticValues();
			
			_urlLoader.removeEventListener(Event.COMPLETE, loadComplete);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, loadError);
			
			_bIsLoading = false;
			trace("loading complete!");
			signalLoadCompleted.dispatch();
		}
				
		/* ---------------------------------------------------------------------------------------- */
		
		private function initializeStaticValues():void 
		{
			//this function probably isn't really needed for anything. all of the data is already stored nicely in the xml object
			//stub
			//trace("initializeStaticValues in xmlmanager is stubbed!");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * handles error on loading xml
		 */
		private function loadError($event:Event = null ):void 
		{
			trace("there was an error while trying to load the xml doc!");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * is the manager still loading the xml file?
		 */
		public function get isLoading():Boolean
		{
			return _bIsLoading;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * the xml config file
		 */
		public function  get xmlConfig():XML
		{
			if (_xmlConfig == null || _bIsLoading)
			{
				trace("Error! The xml file is either still loading, or this singleton has not been initialized!");
				return null;
			}
			
			return _xmlConfig;
		}
		
		/* ---------------------------------------------------------------------------------------- */
				
		/**
		 * Returns an instance to this class.
		 *
		 * @return		An instance to this class.
		 */
		public static function get instance():XMLManager
		{			
			return _instance;
		}
		
		/* ---------------------------------------------------------------------------------------- */		
	}

}


class SingletonLock {} // Do nothing, this is just to prevent external instantiation.
