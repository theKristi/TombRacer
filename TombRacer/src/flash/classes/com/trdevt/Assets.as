package com.trdevt 
{
	
	/**
	 * ...
	 * @author Kristi Marks
	 */
	public class Assets
	{
		/**********************************************Global************************************************************************************/
		[Embed(source = "../../../../fonts/sf_fedora/SF Fedora.ttf", fontFamily = "sffedora", embedAsCFF = "false")] public static var font:Class;
		
		[Embed(source = "../../../../images/background.png")] public static var bgPNG:Class;
		
		[Embed(source = '/CreditsScreen/backButton.png')] public static var backPNG:Class;
		
		/**********************************************Credits************************************************************************************/
		[Embed(source ='/CreditsScreen/CreditsBackbrop.png')] public static var backdropPNG:Class;
		
		[Embed(source ='/CreditsScreen/CreditsHeader.png')] public static var creditsheaderPNG:Class;
		
		[Embed(source='/CreditsScreen/AnthonyDellaCredit.png')]public static var dev1PNG:Class;
		
		[Embed(source='/CreditsScreen/KristiMarksCredit.png')] public static var dev2PNG:Class;
		
		[Embed(source='/CreditsScreen/JakeLongworthCredit.png')] public static var dev3PNG:Class;
		
		[Embed(source = '/CreditsScreen/SawyerZockCredit.png')] public static var dev4PNG:Class;
		
		[Embed(source = '/CreditsScreen/CreditsScrollRect.png')] public static var scrollerOutlinePNG:Class;
		
		/**********************************************Title************************************************************************************/
		[Embed(source = '/MenuScreen/title.png')] public static var titlePNG:Class;
		
		[Embed(source = "../../../../images/PressAnyKey.png")] public static var pressPNG:Class;
		
		/**********************************************Menu************************************************************************************/
		[Embed(source = '/MenuScreen/LevelSelectButton_sheet3.png')] public static var levelSelectPNG:Class;
		
		[Embed(source = '/MenuScreen/CreditsButton_sheet.png')] public static var creditsPNG:Class;
		/**********************************************LevelSelect************************************************************************************/
		
		[Embed(source = '/LevelSelectScreen/LevelSelectHeader.png')] public static var levelheaderPNG:Class;
		
		[Embed(source = '/LevelSelectScreen/LevelUnlocked_notplayed_sheet.png')] public static var levelPNG:Class;
		[Embed(source = "../../../../images/LevelSelectScreen/LevelLocked.png")] public static var levelLockedPNG:Class;
		
		//smallTrophies 
		[Embed(source = "../../../../images/LevelSelectScreen/BronzeTrophy.png")]public static var SmallBronze:Class; 
		[Embed(source = "../../../../images/LevelSelectScreen/SilverTrophy.png")]public static var SmallSilver:Class;
		[Embed(source = "../../../../images/LevelSelectScreen/GoldTrophy.png")]public static var SmallGold:Class; 
		[Embed(source = "../../../../images/LevelSelectScreen/GrayedTrophy.png")]public static var SmallGrayed:Class; 
		
		[Embed(source = "../../../../images/LevelSelectScreen/clearButton.png")] public static var clearButton:Class;
		
		[Embed(source = "../../../../images/LevelSelectScreen/Level1.png")]private static var level1:Class;
		[Embed(source = "../../../../images/LevelSelectScreen/Level2.png")]private static var level2:Class;
		[Embed(source = "../../../../images/LevelSelectScreen/Level3.png")]private static var level3:Class;
		[Embed(source = "../../../../images/LevelSelectScreen/Level4.png")]private static var level4:Class;
		[Embed(source = "../../../../images/LevelSelectScreen/Level5.png")]private static var level5:Class;
		[Embed(source = "../../../../images/LevelSelectScreen/Level6.png")]private static var level6:Class;
		[Embed(source = "../../../../images/LevelSelectScreen/Level7.png")]private static var level7:Class;
		[Embed(source = "../../../../images/LevelSelectScreen/Level8.png")]private static var level8:Class;
		public static var levelGraphics:Array = new Array(level1, level2, level3, level4, level5, level6, level7, level8);
	/**********************************************Sounds************************************************************************************/
		
		[Embed(source = "../../../../sounds/menuBGM2.mp3")] public static var bgMusic:Class;
		
		[Embed(source = '../../../../sounds/buttonClick1.mp3')] public static var buttonClick:Class;
		
	/**********************************************Results************************************************************************************/
		[Embed(source = "../../../../images/ResultsScreen/resultsBack.png")] public static var ResultsBack:Class;
		
		[Embed(source = "../../../../images/ResultsScreen/LevelSelectButtonSmallSheet.png")] public static var LevelSelectSmall:Class;
		
		[Embed(source = "../../../../images/ResultsScreen/NextLevelButtonSheet.png")] public static var NextLevelButton:Class;
		
		[Embed(source = "../../../../images/ResultsScreen/ResultsHeader.png")] public static var ResultsHeader:Class;
		
		[Embed(source = "../../../../images/ResultsScreen/BronzeTrophy.png")] public static var BronzeTrophy:Class;
		[Embed(source = "../../../../images/ResultsScreen/SilverTrophy.png")] public static var SilverTrophy:Class;
		[Embed(source = "../../../../images/ResultsScreen/GoldTrophy.png")] public static var GoldTrophy:Class;
	}
}