<?php
/**
 *
 * Descripcion: Controlador que se encarga de la gestión de los personas del sistema
 *
 * @category    
 * @package     Controllers 
 */

//Load::models('sistema/persona');

class PersonasController extends BackendController {
    
    /**
     * Método que se ejecuta antes de cualquier acción
     */
    protected function before_filter() {
        //Se cambia el nombre del módulo actual
        $this->page_module = 'Gestión de Personas';
    }
    
    /**
     * Método principal
     */
    public function index() {
        Redirect::toAction('listar');
    }
    
    /**
     * Método para buscar
     */
    public function buscar($field='nombre', $value='none', $order='order.id.asc', $page=1) {        
        $page = (Filter::get($page, 'page') > 0) ? Filter::get($page, 'page') : 1;
        $field = (Input::hasPost('field')) ? Input::post('field') : $field;
        $value = (Input::hasPost('field')) ? Input::post('value') : $value;
        
        $persona = new Persona();            
        $personas = $persona->getAjaxPersona($field, $value, $order, $page);        
        if(empty($personas->items)) {
            Flash::info('No se han encontrado registros');
        }
        $this->personas = $personas;
        $this->order = $order;
        $this->field = $field;
        $this->value = $value;
        $this->page_title = 'Búsqueda de personas del sistema';        
    }
    
    /**
     * Método para listar
     */
    public function listar($order='order.id.asc', $page='page.1') { 
        $page = (Filter::get($page, 'page') > 0) ? Filter::get($page, 'page') : 1;
        $persona = new Persona();
        $this->personas = $persona->getListadoPersona('todos', $order, $page);
        $this->order = $order;        
        $this->page_title = 'Listado de personas del sistema';
    }
    
    /**
     * Método para agregar
     */
    public function agregar() {
        if(Input::hasPost('persona')) {
            ActiveRecord::beginTrans();            
            if(Persona::setPersona('create', Input::post('persona'), array('repassword'=>Input::post('repassword'), 'tema'=>'default'))) {
                ActiveRecord::commitTrans();
                Flash::valid('La persona se ha creado correctamente.');
                return Redirect::toAction('listar');
            } else {
                ActiveRecord::rollbackTrans();
            }            
        }
        $this->page_title = 'Agregar persona';
    }
    
    /**
     * Método para editar
     */
    public function editar($key) {        
        if(!$id = DwSecurity::getKey($key, 'upd_persona', 'int')) {
            return Redirect::toAction('listar');
        }        
        
        $persona = new Persona();
        if(!$this->persona = $persona->find_first("id='2'")) {
            Flash::error('Lo sentimos, no se ha podido establecer la información de persona');    
            return Redirect::toAction('listar');
        }                
        
        if(Input::hasPost('persona')) {            
            ActiveRecord::beginTrans();            
            if(Persona::setPersona('update', Input::post('persona'), array('repassword'=>Input::post('repassword'), 'id'=>$id, 'login'=>$persona->login))) {
                ActiveRecord::commitTrans();
                Flash::valid('El persona se ha actualizado correctamente.');
                return Redirect::toAction("editar/$key/");
            } else {
                ActiveRecord::rollbackTrans();
            } 
        }        
        $this->temas = DwUtils::getFolders(dirname(APP_PATH).'/public/css/backend/themes/');
        $this->persona = $persona;
        $this->page_title = 'Actualizar persona';
        
    }
    
    /**
     * Método para ver
     */
    public function ver($key) {        
        if(!$id = DwSecurity::getKey($key, 'shw_persona', 'int')) {
            return Redirect::toAction('listar');
        }
        
        $persona = new Persona();
        if(!$this->persona = $persona->find_first("id='2'")) {
            Flash::error('Lo sentimos, no se ha podido establecer la información de persona');    
            return Redirect::toAction('listar');
        }         
        $this->page_title = 'Información de persona';
        
    }    
    
    /**
     * Método para subir imágenes
     */
    public function upload() {     
        $upload = new DwUpload('fotografia', 'img/upload/personas/');
        $upload->setAllowedTypes('png|jpg|gif|jpeg');
        $upload->setEncryptName(FALSE);
        $upload->setSize('3MB', 170, 200, TRUE);
        if(!$data = $upload->save()) { //retorna un array('path'=>'ruta', 'name'=>'nombre.ext');
            $data = array('error'=>TRUE, 'message'=>$upload->getError());
        }
        sleep(3);//Por la velocidad del script no permite que se actualize el archivo
        $this->data = $data;
        View::json();
    }
    
}

