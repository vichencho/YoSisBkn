<?php
/**
 * Dailyscript - Web | App | Media
 *
 * Descripcion: Controlador que se encarga de la gestión de la empresa
 *
 * @category
 * @package     Controllers
 * @author      Iván D. Meléndez (ivan.melendez@dailycript.com.co)
 * @copyright   Copyright (c) 2013 Dailyscript Team (http://www.dailyscript.com.co)
 */

Load::models('config/empresa', 'config/sucursal', 'sistema/perfil', 'sistema/usuario');

class EmpresaController extends BackendController {

    /**
     * Método que se ejecuta antes de cualquier acción
     */
    protected function before_filter() {
        //Se cambia el nombre del módulo actual
        $this->page_module = 'Configuraciones';
    }

    // protected function after_filter() {
    //     if (Input::isAjax()) {
    //         View::select('ajax', null);
    //     }
    // }
 
    /**
     * Método principal
     */
    public function index() {

        $empresa = new Empresa();
        if(!$empresa->getInformacionEmpresa()) {
            DwMessage::get('id_no_found');
            return DwRedirect::toRoute('module: dashboard', 'controller: index');
        }

        $this->empresa = $empresa;
        $this->page_title = 'Información de la empresa';
    }

    /**
     * Método editar
     */
    public function editar($key) {        
        if(!$id = DwSecurity::getKey($key, 'upd_empresa', 'int')) {
            return Redirect::toAction('index');
        }  
        
        $empresa = new Empresa();
        if(!$empresa->find_first($id)) {
            Flash::error('Lo sentimos, pero no se pudo establecer la información del la Empresa');
            return Redirect::toAction('index');

        }    

        if(Input::hasPost('empresa')) {                            
            if(Empresa::setEmpresa('update', Input::post('empresa'), array('id'=>$id))) {
                Flash::valid('La empresa se ha actualizado correctamente!');  
                return Redirect::to('dashboard/index');
            }            
        }  

        $this->empresa = $empresa;
        $this->page_title = 'Editar Información de la Empresa';
    }
    
    /**
     * Método para subir imágenes
     */
    public function upload() {     
       
        $uploader = new JqfUploader();
        $data = $uploader->upload($_FILES['files'], array(
            'limit' => 10, //Maximum Limit of files. {null, Number}
            'maxSize' => 10, //Maximum Size of files {null, Number(in MB's)}
            'extensions' => null, //Whitelist for file extension. {null, Array(ex: array('jpg', 'png'))}
            'required' => false, //Minimum one file is required for upload {Boolean}
            'uploadDir' => '../../../uploads/', //Upload directory {String}
            'title' => array('name'), //New file name {null, String, Array} *please read documentation in README.md
            'removeFiles' => true, //Enable file exclusion {Boolean(extra for jQuery.filer), String($_POST field name containing json data with file names)}
            'replace' => true, //Replace the file if it already exists  {Boolean}
            'showThumbs' => true, // {Boolean}
            'perms' => null, //Uploaded file permisions {null, Number}
            'onCheck' => null, //A callback function name to be called by checking a file for errors (must return an array) | ($file) | Callback
            'onError' => null, //A callback function name to be called if an error occured (must return an array) | ($errors, $file) | Callback
            'onSuccess' => null, //A callback function name to be called if all files were successfully uploaded | ($files, $metas) | Callback
            'onUpload' => null, //A callback function name to be called if all files were successfully uploaded (must return an array) | ($file) | Callback
            'onComplete' => null, //A callback function name to be called when upload is complete | ($file) | Callback
            'onRemove' => null //A callback function name to be called by removing files (must return an array) | ($removed_files) | Callback
        ));

        if($data['isComplete']){
            $info = $data['data'];
Kint::dump($info);
            echo '<pre>';
            print_r($info);
            echo '</pre>';
        }

        if($data['hasErrors']){
            $errors = $data['errors'];
            print_r($errors);
        }
    }
    
}

