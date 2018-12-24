<?php 
class ControllerFileFile extends Controller {
	public function index() { 
		
		$this->load->model('tool/image');
		$this->load->model('file/file');
		
		//$this->document->addStyle('catalog/view/theme/default/stylesheet/file.css');
		
		$data['files'] = array();
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->model_file_file->getCustomerGroupId($this->customer->getID());
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}
		
		if ($this->config->get('config_customer_group_file') && in_array($customer_group_id, $this->config->get('config_customer_group_file'))){		
		
			$config_file_block_title_tag = ($this->config->get('config_file_block_title_tag'))?$this->config->get('config_file_block_title_tag'):'h3';
			$data['config_file_block_title'] = '<' . $config_file_block_title_tag . '>' . $this->config->get('config_file_block_title') . '</' . $config_file_block_title_tag . '>';
			$data['config_file_block_class'] = $config_file_block_class = ($this->config->get('config_file_block_class'))?$this->config->get('config_file_block_class'):'files';
			$data['config_file_block_a_title'] = $this->config->get('config_file_block_a_title');
			$data['config_file_block_index'] = $this->config->get('config_file_block_index');
			
			$data['config_file_block_positions'] = $this->config->get('config_file_block_positions');
			$data['config_file_block_custom_positions_block'] = $this->config->get('config_file_block_custom_positions_block');
			$data['config_file_block_custom_positions'] = $this->config->get('config_file_block_custom_positions');			
			
			//css + generate styles
			$title_font = $this->config->get('config_file_block_title_style');
			$width = $this->config->get('config_file_block_width');
			$margin = $this->config->get('config_file_block_margin');
			$padding = $this->config->get('config_file_block_padding');
			$border = $this->config->get('config_file_block_border');
			$link_height = $this->config->get('config_file_default_image_size_height').'px!important';
			$a_style = $this->config->get('config_file_block_a_style');	
			$title_color = $this->config->get('config_file_block_title_color');
			$title_margin = $this->config->get('config_file_block_title_margin');
			$radius = $this->config->get('config_file_block_radius');
			$a_color = $this->config->get('config_file_block_a_color');
			$a_margin = $this->config->get('config_file_block_a_margin');
			$a_decoration = $this->config->get('config_file_block_a_decoration')?'':'text-decoration:none;';

			
			$user_style = $this->config->get('config_file_block_styles');
			$data['file_css'] = "
				.$config_file_block_class, .$config_file_block_class *{box-sizing:border-box;}
				.$config_file_block_class{width:$width;margin:$margin;padding:$padding;border:$border;border-radius:$radius;}
				.$config_file_block_class $config_file_block_title_tag{font:$title_font;margin:$title_margin;color:$title_color;}
				.$config_file_block_class .file-item{margin:$a_margin;}				
				.$config_file_block_class .file-item span{height:$link_height;}
				.$config_file_block_class .file-item span a{font:$a_style;line-height:$link_height;color:$a_color;$a_decoration}
				 $user_style
			";
			
			$files_data = $this->model_file_file->getProductFiles($this->request->get['product_id']);
			

			foreach ($files_data as $file) {
				if ($file['image'] && $file['image'] != 'no_image.jpg' ) {
					$image = $this->model_tool_image->resize($file['image'], ($this->config->get('config_file_default_image_size_width'))?$this->config->get('config_file_default_image_size_width'):50, ($this->config->get('config_file_default_image_size_height'))?$this->config->get('config_file_default_image_size_height'):50);
				} else {
					$image = false;
				}
				
				if(file_exists(str_replace("system/storage/download", "files", DIR_DOWNLOAD) . $file['file'])) {
					$file_link = HTTP_SERVER . 'files/' . $file['file']; 
				}else{
					$file_link = false;
				}
				
				if($file_link){
					$data['files'][] = array(
						'file_id' 	=> $file['file_id'],
						'href'    	=> $file_link, 
						'image'   	=> $image,
						'name' 		=> $file['name'],
						'title' 	=> $file['title'],
					);
				}
			}				
		}				
		
		return $this->load->view('file/file', $data);
			
  	}
}
?>