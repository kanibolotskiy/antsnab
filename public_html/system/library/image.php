<?php
final class Image {
    private $file;
    private $image;
    private $info;
		
	public function __construct($file) {
		if (file_exists($file)) {
			$this->file = $file;

			$info = getimagesize($file);

			$this->info = array(
            	'width'  => $info[0],
            	'height' => $info[1],
            	'bits'   => $info['bits'],
            	'mime'   => $info['mime']
        	);
        	
        	$this->image = $this->create($file);
    	} else {
      		exit('Error: Could not load image ' . $file . '!');
    	}
	}
		
	private function create($image) {
		$mime = $this->info['mime'];
		
		if ($mime == 'image/gif') {
			return imagecreatefromgif($image);
		} elseif ($mime == 'image/png') {
			return imagecreatefrompng($image);
		} elseif ($mime == 'image/jpeg') {
			return imagecreatefromjpeg($image);
		}
    }	
	
    public function save($file, $quality = 90) {
        $info = pathinfo($file);
        $extension = strtolower($info['extension']);
   
        if ($extension == 'jpeg' || $extension == 'jpg') {
            imagejpeg($this->image, $file, $quality);
        } elseif($extension == 'png') {
            imagepng($this->image, $file, 3);
        } elseif($extension == 'gif') {
            imagegif($this->image, $file);
        }
		   
	    imagedestroy($this->image);
    }	    
	public function myResize($filename, $width, $height, $type = "", $watermark="") {
		//echo "!myResize!<br/><br/>";
		if (!is_file(DIR_IMAGE . $filename)) {
			if (is_file(DIR_IMAGE . 'no_image.jpg')) {
				$filename = 'no_image.jpg';
			} elseif (is_file(DIR_IMAGE . 'no_image.png')) {
				$filename = 'no_image.png';
			} else {
				return;
			}
		}
		$info = pathinfo($filename);
		$extension = $info['extension'];
		$old_image = $filename;

		$new_image = 'cache/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-' . $width . 'x' . $height . $type .'.' . $extension;
		if (!file_exists(DIR_IMAGE . $new_image) || (filemtime(DIR_IMAGE . $old_image) > filemtime(DIR_IMAGE . $new_image))) {
			$path = '';
			$directories = explode('/', dirname(str_replace('../', '', $new_image)));
			foreach ($directories as $directory) {
				$path = $path . '/' . $directory;
				if (!file_exists(DIR_IMAGE . $path)) {
					@mkdir(DIR_IMAGE . $path, 0777);
				}
			}
			list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $old_image);
			if ($width_orig != $width || $height_orig != $height) {
				$scaleW = $width_orig/$width;
				$scaleH = $height_orig/$height;
				$image = new Image(DIR_IMAGE . $old_image);
				if ($scaleH > $scaleW) {
					$_height = $height * $scaleW;
					$top_x = 0;
					$top_y = ($height_orig - $_height) / 2;
					$bottom_x = $width_orig;
					$bottom_y = $top_y + $_height;
					$image->crop($top_x, $top_y, $bottom_x, $bottom_y);
				} elseif ($scaleH < $scaleW) {
					$_width = $width * $scaleH;
					$top_x = ($width_orig - $_width) / 2;
					$top_y = 0;
					$bottom_x = $top_x + $_width;
					$bottom_y = $height_orig;
					$image->crop($top_x, $top_y, $bottom_x, $bottom_y);
				}
				$image->resize($width, $height);
				if($watermark){
					$image->watermark(new Image(DIR_IMAGE . 'watermark.png'), 'middlecenter');
				}
				$image->save(DIR_IMAGE . $new_image);
			} else {
				if($watermark){
					$image = new Image(DIR_IMAGE . $old_image);
					$image->watermark(new Image(DIR_IMAGE . 'watermark.png'), 'middlecenter');
					$image->save(DIR_IMAGE . $new_image);
				}else{
					copy(DIR_IMAGE . $old_image, DIR_IMAGE . $new_image);
				}
			}
		}
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			return $this->config->get('config_ssl') . 'image/' . $new_image;
		} else {
			return $this->config->get('config_url') . 'image/' . $new_image;
		}
				

	}
    public function resize($width = 0, $height = 0) {
		//echo "!resize!<br/><br/>";

    	if (!$this->info['width'] || !$this->info['height']) {
			return;
		}

		$xpos = 0;
		$ypos = 0;

		$scale = min($width / $this->info['width'], $height / $this->info['height']);
		
		if ($scale == 1) {
			return;
		}
		
		$new_width = (int)($this->info['width'] * $scale);
		$new_height = (int)($this->info['height'] * $scale);			
    	$xpos = (int)(($width - $new_width) / 2);
   		$ypos = (int)(($height - $new_height) / 2);
        		        
       	$image_old = $this->image;
        $this->image = imagecreatetruecolor($width, $height);
		
		if (isset($this->info['mime']) && $this->info['mime'] == 'image/png') {		
			imagealphablending($this->image, false);
			imagesavealpha($this->image, true);
			$background = imagecolorallocatealpha($this->image, 255, 255, 255, 127);
			imagecolortransparent($this->image, $background);
		} else {
			$background = imagecolorallocate($this->image, 255, 255, 255);
		}
		
		imagefilledrectangle($this->image, 0, 0, $width, $height, $background);
	
        imagecopyresampled($this->image, $image_old, $xpos, $ypos, 0, 0, $new_width, $new_height, $this->info['width'], $this->info['height']);
        imagedestroy($image_old);
           
        $this->info['width']  = $width;
        $this->info['height'] = $height;
    }
    
    
    ###################################################
    #
    # - Jerome Bohg - 05 juli 2011
    #
    # custom functie gemaakt om uitsnedes te maken 
    # voor images ipv de hele foto weer te geven met
    # witrumte eromheen
    #
    
	    public function cropsize($width = 0, $height = 0) {
	    
	    	if (!$this->info['width'] || !$this->info['height']) {
	    		return;
	    	}
        
	        //afmetingen bepalen
	        $photo_width = $this->info['width']; 
	        $photo_height = $this->info['height'];
	        
	        $new_width = $width;
	        $new_height = $height;
	        
	        //als foto te hoog is
	        if (($photo_width/$new_width) < ($photo_height/$new_height)) {
	        
	        	$from_y = ceil(($photo_height - ($new_height * $photo_width / $new_width))/2);
	        	$from_x = '0';
	        	$photo_y = ceil(($new_height * $photo_width / $new_width)); 
	        	$photo_x = $photo_width;
	        
	        }
	        
	        //als foto te breed is
	        if (($photo_height/$new_height) < ($photo_width/$new_width)) {

	        	$from_x = ceil(($photo_width - ($new_width * $photo_height / $new_height))/2);
	        	$from_y = '0';
	        	$photo_x = ceil(($new_width * $photo_height / $new_height)); 
	        	$photo_y = $photo_height;

        	}
	        
	        //als verhoudingen gelijk zijn	
	        if (($photo_width/$new_width) == ($photo_height/$new_height)) {
	        
	        	$from_x = ceil(($photo_width - ($new_width * $photo_height / $new_height))/2);
	        	$from_y = '0';
	        	$photo_x = ceil(($new_width * $photo_height / $new_height)); 
	        	$photo_y = $photo_height;
	        
	        }
	        
	        	        
	       	$image_old = $this->image;
	        $this->image = imagecreatetruecolor($width, $height);
			
			if (isset($this->info['mime']) && $this->info['mime'] == 'image/png') {		
				imagealphablending($this->image, false);
				imagesavealpha($this->image, true);
				$background = imagecolorallocatealpha($this->image, 255, 255, 255, 127);
				imagecolortransparent($this->image, $background);
			} else {
				$background = imagecolorallocate($this->image, 255, 255, 255);
			}
			
			imagefilledrectangle($this->image, 0, 0, $width, $height, $background);
		
		
	        imagecopyresampled($this->image, $image_old, 0, 0, $from_x, $from_y, $new_width, $new_height, $photo_x, $photo_y);
	        imagedestroy($image_old);
	           
	        $this->info['width']  = $width;
	        $this->info['height'] = $height;

	    
	    }
    

    ###################################################
    #
    # - Jerome Bohg - 12 juli 2011
    #
    # custom functie gemaakt om foto's te verschalen 
    # zonder witruimte er omheen.
    #
    
	    public function onesize($maxsize = 0) {
	    
	    	if (!$this->info['width'] || !$this->info['height']) {
	    		return;
	    	}
        
	        //afmetingen bepalen
	        $photo_width = $this->info['width']; 
	        $photo_height = $this->info['height'];
 	        
	        
	        // calculate dimensions
        	if ($photo_width > $maxsize OR $photo_height > $maxsize) {
        	
        		if ($photo_width == $photo_height) {
        		
        			$width = $maxsize;
        			$height = $maxsize;
        	 	
        	 	}elseif($photo_width > $photo_height) {
        	 	
        		    	$scale = $photo_width / $maxsize;
        		  		$width = $maxsize;
        				$height = round ($photo_height / $scale);
        		
        		}else{
        		
        			$scale = $photo_height / $maxsize;
        			$height = $maxsize;
        			$width = round ($photo_width / $scale);
        		
        		}
        	
        	}else{
        	
        		$width = $photo_width;
        		$height = $photo_height;
        	
        	}
	        	
	        // and bring it all to live	        
	       	$image_old = $this->image;
	        $this->image = imagecreatetruecolor($width, $height);
			
			if (isset($this->info['mime']) && $this->info['mime'] == 'image/png') {		
				imagealphablending($this->image, false);
				imagesavealpha($this->image, true);
				$background = imagecolorallocatealpha($this->image, 255, 255, 255, 127);
				imagecolortransparent($this->image, $background);
			} else {
				$background = imagecolorallocate($this->image, 255, 255, 255);
			}
			
			imagefilledrectangle($this->image, 0, 0, $width, $height, $background);
		
		
	        imagecopyresampled($this->image, $image_old, 0, 0, 0, 0, $width, $height, $photo_width, $photo_height);
	        imagedestroy($image_old);
	           
	        $this->info['width']  = $width;
	        $this->info['height'] = $height;

	    
	    }
    
    
    ###################################################
    
    
    public function watermark($file, $position = 'bottomright') {
		if($file){
			$watermark = $this->create($file);
			$watermark_width = imagesx($watermark);
			$watermark_height = imagesy($watermark);
			
			switch($position) {
				case 'topleft':
					$watermark_pos_x = 0;
					$watermark_pos_y = 0;
					break;
				case 'topright':
					$watermark_pos_x = $this->info['width'] - $watermark_width;
					$watermark_pos_y = 0;
					break;
				case 'bottomleft':
					$watermark_pos_x = 0;
					$watermark_pos_y = $this->info['height'] - $watermark_height;
					break;
				case 'bottomright':
					$watermark_pos_x = $this->info['width'] - $watermark_width;
					$watermark_pos_y = $this->info['height'] - $watermark_height;
					break;
			}
			
			imagecopy($this->image, $watermark, $watermark_pos_x, $watermark_pos_y, 0, 0, 120, 40);
			
			imagedestroy($watermark);
		}
    }
    
    public function crop($top_x, $top_y, $bottom_x, $bottom_y) {
        $image_old = $this->image;
        $this->image = imagecreatetruecolor($bottom_x - $top_x, $bottom_y - $top_y);
        
        imagecopy($this->image, $image_old, 0, 0, $top_x, $top_y, $this->info['width'], $this->info['height']);
        imagedestroy($image_old);
        
        $this->info['width'] = $bottom_x - $top_x;
        $this->info['height'] = $bottom_y - $top_y;
    }
    
    public function rotate($degree, $color = 'FFFFFF') {
		$rgb = $this->html2rgb($color);
		
        $this->image = imagerotate($this->image, $degree, imagecolorallocate($this->image, $rgb[0], $rgb[1], $rgb[2]));
        
		$this->info['width'] = imagesx($this->image);
		$this->info['height'] = imagesy($this->image);
    }
	    
    private function filter($filter) {
        imagefilter($this->image, $filter);
    }
            
    private function text($text, $x = 0, $y = 0, $size = 5, $color = '000000') {
		$rgb = $this->html2rgb($color);
        
		imagestring($this->image, $size, $x, $y, $text, imagecolorallocate($this->image, $rgb[0], $rgb[1], $rgb[2]));
    }
    
    private function merge($file, $x = 0, $y = 0, $opacity = 100) {
        $merge = $this->create($file);

        $merge_width = imagesx($image);
        $merge_height = imagesy($image);
		        
        imagecopymerge($this->image, $merge, $x, $y, 0, 0, $merge_width, $merge_height, $opacity);
    }
			
	private function html2rgb($color) {
		if ($color[0] == '#') {
			$color = substr($color, 1);
		}
		
		if (strlen($color) == 6) {
			list($r, $g, $b) = array($color[0] . $color[1], $color[2] . $color[3], $color[4] . $color[5]);   
		} elseif (strlen($color) == 3) {
			list($r, $g, $b) = array($color[0] . $color[0], $color[1] . $color[1], $color[2] . $color[2]);    
		} else {
			return FALSE;
		}
		
		$r = hexdec($r); 
		$g = hexdec($g); 
		$b = hexdec($b);    
		
		return array($r, $g, $b);
	}	
}
?>