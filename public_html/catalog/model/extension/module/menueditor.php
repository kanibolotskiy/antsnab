<?php
//@task не работает,когда файл называется menu_editor
class ModelExtensionModuleMenueditor extends Model
{

    public function getMenuContent($side = 0, $language_id)
    {
        $q = $this->db->query("SELECT * FROM `" . DB_PREFIX . "special_label` WHERE language_id = $language_id");
        return $q->row['label'];
    }

//@task move to override
    public function getEntries()
    {
        $config = $this->config;
        $pre_menu = array();
        $post_menu = array();
        $menu_editor_entries = $config->get('menu_editor_entries');

        foreach ($menu_editor_entries as $menu_editor_entry) {
            if ($menu_editor_entry['position'] == 0) {
                $pre_menu[] = array('name' => $menu_editor_entry['names'][$config->get('config_language_id')],
                    'children' => array(),
                    'column' => 1,
                    // 'href' => $this->url->link($menu_editor_entry['href']),
                    'href' => $menu_editor_entry['href'],
                    'isactive' => $this->isUrlActive($menu_editor_entry['href']),
                    'target' => $menu_editor_entry['target']);
            } else {
                $post_menu[] = array('name' => $menu_editor_entry['names'][$config->get('config_language_id')],
                    'children' => array(),
                    'column' => 1,
                    // 'href' => $this->url->link($menu_editor_entry['href']),
                    'href' => $menu_editor_entry['href'],
                    'isactive' => $this->isUrlActive($menu_editor_entry['href']),
                    'target' => $menu_editor_entry['target']);
            }
        }
        return array_merge($pre_menu, $post_menu);
    }

    private function isUrlActive($url)
    {
        //clean from special
        $url = html_entity_decode($url);
        //clean the given url from domain and protocol without afterward slash
        $pattern = "~^(https?:\/\/|www\.)" . $_SERVER['HTTP_HOST'] . "~";
        $url = preg_replace($pattern, "", $url);

        //we need exactly one leading slash 
        $url = preg_replace("/^\/*/", "/", $url);
        /*var_dump($url);
        var_dump($_SERVER['REQUEST_URI']);*/

        return $url === $_SERVER['REQUEST_URI'];
    }


}
