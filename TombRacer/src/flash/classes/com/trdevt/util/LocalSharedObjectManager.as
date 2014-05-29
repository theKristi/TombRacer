package com.trdevt.util 
{
	import flash.net.SharedObject;
	/**
	 * for now, this class will be mostly generic with only one or two function specific to this project. in the future an abstract base class will be created
	 * 
	 * @author Jake
	 */
	public class LocalSharedObjectManager 
	{
		/**
		 * the instance of the singleton LSO manager, starts off null, but will be created later
		 */
		private static const _instance			:LocalSharedObjectManager = new LocalSharedObjectManager( SingletonLock );
		
		/**
		 * internal reference to the local shared object
		 */
		private var _soLocal:SharedObject = null;
		
		/**
		 * the name of the local shared object
		 */
		private var _sLSOName:String;
				
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * creates the singleton LSO manager, should never be called directly! Call init() instead
		 */
		public function LocalSharedObjectManager($lock:Class) 
		{
			if ($lock != SingletonLock)
				throw new Error("LocalSharedObjectManager is a singleton and should not be instantiated. Use LocalSharedObjectManager.instance instead");
				
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * creates the single instance of the LSO manager.
		 * @param	$sName the name of the local shared object
		 * @param	$sPath the path to the local shared object, default is null
		 */
		public function init($sName:String, $sPath:String=null):void 
		{
			//_instanceLSOM = new LocalSharedObjectManager(new SingletonLock());
			
			_soLocal = SharedObject.getLocal($sName, $sPath);
			
			if (_soLocal.size == 0)
			{
				//local so does not exist, create it
				createDefaultLSO();
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * this function is project specific and loads in the default values
		 */
		private function createDefaultLSO():void 
		{
			//stub
			trace("Warning! Calling stubbed function createDefaultLSO in LocalSharedObjectManager!");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * get value from LSO with passed in key
		 */
		public function geValue(key:String):String
		{
			if (!_soLocal)
			{
				trace("LocalSharedObjectManager has not been initialized! call init first!");
				return "";
			}
			
			var value:String;
			
			value = String(_soLocal.data[key]);
			
			return value;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * store given value with given key in lso
		 */
		public function setValue(key:String, value:String):void 
		{
			if (!_soLocal)
			{
				trace("LocalSharedObjectManager has not been initialized! call init first!");
				return;
			}

			_soLocal.data[key] = value;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Returns an instance to this class.
		 *
		 * @return		An instance to this class.
		 */
		public static function get instance():LocalSharedObjectManager
		{
			return _instance;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * debug function for resetting the values in the shared object to their defaults
		 */
		public function resetSharedOBject():void 
		{
			if (_soLocal.size == 0)
				return;
			
			//stub
			trace("Warning! Calling stubbed function resetSharedOBject in LocalSharedObjectManager!");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}

}


class SingletonLock {} // Do nothing, this is just to prevent external instantiation.
