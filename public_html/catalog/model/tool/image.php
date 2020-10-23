<?php
class ModelToolImage extends Model {
	// Function to crop an image with given dimensions. What doesn/t fit will be cut off.
	function cropsize($filename, $width, $height) {
	
		if (!file_exists(DIR_IMAGE . $filename) || !is_file(DIR_IMAGE . $filename)) {
			return;
		} 
		
		$info = pathinfo($filename);
		$extension = $info['extension'];
		
		$old_image = $filename;
		$new_image = 'cache/' . substr($filename, 0, strrpos($filename, '.')) . '-cr-' . $width . 'x' . $height . '.' . $extension;
		
		if (!file_exists(DIR_IMAGE . $new_image) || (filemtime(DIR_IMAGE . $old_image) > filemtime(DIR_IMAGE . $new_image))) {
			$path = '';
			
			$directories = explode('/', dirname(str_replace('../', '', $new_image)));
			
			foreach ($directories as $directory) {
				$path = $path . '/' . $directory;
				
				if (!file_exists(DIR_IMAGE . $path)) {
					@mkdir(DIR_IMAGE . $path, 0777);
				}		
			}
			
			$image = new Image(DIR_IMAGE . $old_image);
			$image->cropsize($width, $height);
			$image->save(DIR_IMAGE . $new_image);
		}
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			return $this->config->get('config_ssl') . 'image/'. $new_image;
		} else {
			return $this->config->get('config_url') . 'image/' . $new_image;
		}
			
	}
	
	// Function to resize image with one given max size.
	function onesize($filename, $maxsize) {
	
		if (!file_exists(DIR_IMAGE . $filename) || !is_file(DIR_IMAGE . $filename)) {
			return;
		} 
		
		$info = pathinfo($filename);
		$extension = $info['extension'];
		
		$old_image = $filename;
		$new_image = 'cache/' . substr($filename, 0, strrpos($filename, '.')) . '-max-' . $maxsize . '.' . $extension;
		
		if (!file_exists(DIR_IMAGE . $new_image) || (filemtime(DIR_IMAGE . $old_image) > filemtime(DIR_IMAGE . $new_image))) {
			$path = '';
			
			$directories = explode('/', dirname(str_replace('../', '', $new_image)));
			
			foreach ($directories as $directory) {
				$path = $path . '/' . $directory;
				
				if (!file_exists(DIR_IMAGE . $path)) {
					@mkdir(DIR_IMAGE . $path, 0777);
				}		
			}
			
			$image = new Image(DIR_IMAGE . $old_image);
			$image->onesize($maxsize);
			$image->save(DIR_IMAGE . $new_image);
		}
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			return $this->config->get('config_ssl') . 'image/'. $new_image;
		} else {
			return $this->config->get('config_url') . 'image/' . $new_image;
		}
			
	}
	public function myResize($filename, $width, $height, $type = "", $watermark="") {
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
				$image->resize($width, $height, $type);
				if($watermark){
					$image->watermark(new Image(DIR_IMAGE . 'watermark.png'));
				}
				
				$image->save(DIR_IMAGE . $new_image);
            } else {
				
				if($watermark){
					$image = new Image(DIR_IMAGE . $old_image);
					$image->watermark(new Image(DIR_IMAGE . 'watermark.png'));
					$image->save(DIR_IMAGE . $new_image);
				}else{
					copy(DIR_IMAGE . $old_image, DIR_IMAGE . $new_image);
				}
				
			}
			$this->makeWebP('image/'.$new_image);
		}

        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            return $this->config->get('config_ssl') . 'image/' . $new_image;
        } else {
            return $this->config->get('config_url') . 'image/' . $new_image;
        }
	}
	

	public function resize($filename, $width, $height) {
		if (!is_file(DIR_IMAGE . $filename)) {
			if (is_file(DIR_IMAGE . 'no_image.jpg')) {
				$filename = 'no_image.jpg';
			} elseif (is_file(DIR_IMAGE . 'no_image.png')) {
				$filename = 'no_image.png';
			} else {
				return;
			}
		}

		$extension = pathinfo($filename, PATHINFO_EXTENSION);

		$image_old = $filename;
		$image_new = 'cache/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-' . (int)$width . 'x' . (int)$height . '.' . $extension;

		if (!is_file(DIR_IMAGE . $image_new) || (filectime(DIR_IMAGE . $image_old) > filectime(DIR_IMAGE . $image_new))) {
			list($width_orig, $height_orig, $image_type) = getimagesize(DIR_IMAGE . $image_old);

			if (!in_array($image_type, array(IMAGETYPE_PNG, IMAGETYPE_JPEG, IMAGETYPE_GIF))) {
				return DIR_IMAGE . $image_old;
			}

			$path = '';

			$directories = explode('/', dirname($image_new));

			foreach ($directories as $directory) {
				$path = $path . '/' . $directory;

				if (!is_dir(DIR_IMAGE . $path)) {
					@mkdir(DIR_IMAGE . $path, 0777);
				}
			}

			if ($width_orig != $width || $height_orig != $height) {
				$image = new Image(DIR_IMAGE . $image_old);
				$image->resize($width, $height);
				$image->save(DIR_IMAGE . $image_new);
			} else {
				copy(DIR_IMAGE . $image_old, DIR_IMAGE . $image_new);
			}
			$this->makeWebP('image/'.$image_new);
		}

		$imagepath_parts = explode('/', $image_new);
		$new_image = implode('/', array_map('rawurlencode', $imagepath_parts));
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			return $this->config->get('config_ssl') . 'image/' . $new_image;
		} else {
			return $this->config->get('config_url') . 'image/' . $new_image;
		}
	}
	public function makeWebP($file_f){
		$info_f = pathinfo($file_f);
		$ext_f=$info_f['extension'];
		if($ext_f=='jpg' or $ext_f=='png'){
			if($ext_f=='jpg'){
			  $img = imageCreateFromJpeg($file_f);
			}
			if($ext_f=='png'){
			  $img = imageCreateFromPng($file_f);
			}
			$new=$info_f['dirname'] . '/' . $info_f['filename'] . '.' . 'webp';
			imageWebp($img, $new, 100);
			if (filesize($new) % 2 == 1) {
				file_put_contents($new, "\0", FILE_APPEND);
			}
			imagedestroy($img);
		}
	}
}
