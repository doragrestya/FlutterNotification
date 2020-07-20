<?php

      defined('BASEPATH') OR exit('No Script Direct');

      class Api extends CI_Controller{
      	function __construct(){
      		parent:: __construct();
      		date_default_timezone_set('Asia/Jakarta');
      		error_reporting(E_ALL);
      		ini_set('Display Error', 1);
      	}

            function deleteNews(){
                  $idNews = $this->input->post('idnews');
                  $this->db->where('id_news', $idNews);

                  $status = $this->db->delete('tb_news');
                  if ($status == true){
                        $data['message'] = "Successfully delete news";
                        $data['status'] = 200;
                  }else {
                        $data['message'] = "Failed delete news";
                        $data['status'] = 404;
                  }
                  echo json_encode($data);
            }

      	function getNews(){
                  $idUser = $this->input->post('iduser');
                  $this->db->order_by('date_news', 'DESC');
                  $this->db->where('id_user', $idUser);
                  $query = $this->db->get('tb_news');
                  //$query = $this->db->get('tb_news');
                  if($idUser != null || $idUser != ""){
                        if($query -> num_rows() > 0){
                              $data['message'] = "Successfully Get Data News With Id";
                              $data['status'] = 200;
                              $data['article'] = $query->result();
                        }else{
                              $data['message'] = "Failed Get Data News";
                              $data['status'] = 400;
                        }
                  } else {
                         $q = $this->db->get('tb_news');
                         if($q -> num_rows() > 0){
                              $data['message'] = "Successfully Get Data News Without Id";
                              $data['status'] = 200;
                              $data['article'] = $q->result();
                        }else{
                              $data['message'] = "Failed Get Data News";
                              $data['status'] = 400;
                        }

                  }
                  echo json_encode($data);
            }

            function addNews(){
                  $title = $this->input->post('title');
                  $descript = $this->input->post('description');
                  $config['upload_path'] = './image_news/';
                  $config['allowed_types'] = 'gif|jpg|png|jpeg';

                  $this->load->library('upload', $config);

                  if (! $this->upload->do_upload('image')) {
                        $error = array('error' => $this->upload->display_errors());
                        $data1 = array(
                              'message' => $error,
                              'status' => 404,
                        );
                  } else {
                        //upload to folder
                        $data = array('upload_data' => $this->upload->data());

                        //upload to database 
                        $save['title_news'] = $title;
                        $save['image_news'] = $data['upload_data']['file_name'];
                        $save['description_news'] = $descript;
                        $save['date_news'] = date('Y-m-d');
                        $query = $this->db->insert('tb_news', $save);

                        //output request
                        $data1 = array(
                              'message' => 'Successfully Upload News',
                              'status' => 200,
                              'data' => $data['upload_data']['file_name'],
                        );
                  }

                  echo json_encode($data1);
            }
      }
?>