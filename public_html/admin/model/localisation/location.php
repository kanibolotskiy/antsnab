<?php
class ModelLocalisationLocation extends Model {
	/**Добавляем файлы для загрузки для локализаций */
	public function getLocationDownloads($location_id)
    {
        $location_download_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "location_to_download WHERE location_id = '" . (int) $location_id . "'");

        foreach ($query->rows as $result) {
            $location_download_data[] = $result['download_id'];
        }

        return $location_download_data;
	}
	
	public function addLocation($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "location SET name = '" . $this->db->escape($data['name']) . "', address = '" . $this->db->escape($data['address']) . "', geocode = '" . $this->db->escape($data['geocode']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', image = '" . $this->db->escape($data['image']) . "', open = '" . $this->db->escape($data['open']) . "', comment = '" . $this->db->escape($data['comment']) . "', map = '" . $this->db->escape($data['map']) . "'");
		
		$location_id=$this->db->getLastId();	
		if (isset($data['location_download'])) {
            foreach ($data['location_download'] as $download_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "location_to_download SET location_id = '" . (int) $location_id . "', download_id = '" . (int) $download_id . "'");
            }
		}
		
		return $location_id;
	}

	public function editLocation($location_id, $data) {

		$this->db->query("UPDATE " . DB_PREFIX . "location SET name = '" . $this->db->escape($data['name']) . "', address = '" . $this->db->escape($data['address']) . "', geocode = '" . $this->db->escape($data['geocode']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', image = '" . $this->db->escape($data['image']) . "', open = '" . $this->db->escape($data['open']) . "', comment = '" . $this->db->escape($data['comment']) . "', map = '" . $this->db->escape($data['map']) . "' WHERE location_id = '" . (int)$location_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "location_to_download WHERE location_id = '" . (int) $location_id . "'");

        if (isset($data['location_download'])) {
            foreach ($data['location_download'] as $download_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "location_to_download SET location_id = '" . (int) $location_id . "', download_id = '" . (int) $download_id . "'");
            }
        }
	}

	public function deleteLocation($location_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "location WHERE location_id = " . (int)$location_id);
		$this->db->query("DELETE FROM " . DB_PREFIX . "location_to_download WHERE location_id = '" . (int) $location_id . "'");
	}

	public function getLocation($location_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "location WHERE location_id = '" . (int)$location_id . "'");

		return $query->row;
	}

	public function getLocations($data = array()) {
		$sql = "SELECT location_id, name, address FROM " . DB_PREFIX . "location";

		$sort_data = array(
			'name',
			'address',
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY name";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getTotalLocations() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "location");

		return $query->row['total'];
	}
}
