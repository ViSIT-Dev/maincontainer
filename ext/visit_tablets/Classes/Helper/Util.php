<?php

namespace Visit\VisitTablets\Helper;

/***
 *
 * This file is part of the "tablets" Extension for TYPO3 CMS.
 *
 * For the full copyright and license information, please read the
 * LICENSE.txt file that was distributed with this source code.
 *
 *  (c) 2018 Kris Raich
 *
 ***/

/**
 * Description of Constants
 *
 * @author RaichKrispin
 */
class Util {


    public static function getLanguages(){

        $resLang =
            self::getInstance(\TYPO3\CMS\Core\Database\ConnectionPool::class)
            ->getConnectionForTable("sys_language")
            ->createQueryBuilder()
            ->select('*')
            ->from('sys_language')
            ->execute();

        $languages = [
            0 =>  [
                "uid" => 0,
                "title" => "DE",
                "languageIsocode" => "de"
            ]
        ];

        while($lang = $resLang->fetch()){
            $languages[$lang["uid"]] = [
                "uid" => $lang["uid"],
                "title" => $lang["title"],
                "languageIsocode" => $lang["language_isocode"]
            ];
        }

        return $languages;
    }

    
    public static function getLanguageNameById($sysLanguageId){
        return self::getLanguages()[$sysLanguageId]["title"];
    }


    public static function translate($key){
        \TYPO3\CMS\Extbase\Utility\LocalizationUtility::translate($key, Constants::$EXTENSION_NAME);
    }

    /**
     * Use for Classes with \TYPO3\CMS\Core\SingletonInterface
     * Does not inject dependencies
     *
     * @param type $className
     * @return type
     */
    public static function makeInstance($className) {
        return \TYPO3\CMS\Core\Utility\GeneralUtility::makeInstance($className);
    }

    public static function getUriBuilder(){
        return self::getInstance('TYPO3\CMS\Extbase\Mvc\Web\Routing\UriBuilder');
    }

    /**
     * Use for other stuff like Repositories (injects dependencies)
     * @param type $className
     * @return type
     */
    public static function getInstance($className) {
        $objectManager = self::makeInstance('TYPO3\CMS\Extbase\Object\ObjectManager');
        return $objectManager->get($className);
    }

    public static function debug($var) {
        $bt = debug_backtrace();
        $caller = array_shift($bt);
        \TYPO3\CMS\Core\Utility\DebugUtility::debug($var, 'Debug: ' . $caller['file'] . ' in Line: ' . $caller['line']);
    }

    public static function getConfig($title, $language = 0){
        return self::getInstance('Visit\VisitTablets\Domain\Repository\ConfigRepository')->get($title, $language);
    }

    public static function getConfigForAllLanguages($title){
        return self::getInstance('Visit\VisitTablets\Domain\Repository\ConfigRepository')->getForAllLanguages($title);
    }

}
