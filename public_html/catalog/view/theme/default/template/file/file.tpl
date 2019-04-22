<?php if($files){ ?>
	<style><?php echo $file_css; ?></style>  
	<div class="<?php echo $config_file_block_class; ?>">
	<?php if($config_file_block_index){ ?><!--noindex--><?php } ?>
	  <?php if($config_file_block_title){ ?><?php echo $config_file_block_title; ?><?php } ?>
	  <div class="file-items">
		<?php foreach($files as $file){ ?>
			<div class="file-item">
				<?php if($file['image']){ ?>
					<span><a download href="<?php echo $file['href']; ?>" <?php if($file['title'] && $config_file_block_a_title){ ?>title="<?php echo $file['title']; ?>"<?php } ?> <?php if($config_file_block_index){ ?>rel="nofollow"<?php } ?> ><img src="<?php echo $file['image']; ?>" alt="<?php echo $file['title']; ?>"></a></span>
				<?php } ?>
				<span><a download href="<?php echo $file['href']; ?>" <?php if($file['title'] && $config_file_block_a_title){ ?>title="<?php echo $file['title']; ?>"<?php } ?> <?php if($config_file_block_index){ ?>rel="nofollow"<?php } ?> ><?php echo $file['name']; ?></a></span>
			</div>
		<?php } ?>
      </div>
	<?php if($config_file_block_index){ ?><!--/noindex--><?php } ?>	  
    </div>
<?php } ?>