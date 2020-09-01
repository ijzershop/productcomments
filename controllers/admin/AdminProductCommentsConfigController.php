<?php 

use PrestaShop\PrestaShop\Adapter\SymfonyContainer;

class AdminProductCommentsConfigController extends ModuleAdminController
{
    public function init()
    {
        $sfContainer = SymfonyContainer::getInstance();
        if (!is_null($sfContainer)) {
            $sfRouter = $sfContainer->get('router');
            Tools::redirectAdmin(Context::getContext()->link->getAdminLink('AdminModules', true, [], array('configure'=>'productcomments')));
        }
    }
}


?>