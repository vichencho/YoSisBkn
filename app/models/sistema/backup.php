<?php
/**
 *
 * Descripcion: Modelo para el manejo de las copias de seguridad
 *
 * @category
 * @package     Models
 * @subpackage
 */

class Backup extends ActiveRecord {
    
    /**
     * Método para definir las relaciones y validaciones
     */
    protected function initialize() {       
        $this->belongs_to('usuario');        
    }
                    
    /**
     * Método para buscar usuarios
     */
    public function getAjaxBackup($field, $value, $order='', $page=0) {
        $value = Filter::get($value, 'string');

        $columns    = 'backup.*, persona.nombre, persona.apellido';        
        $join       = 'INNER JOIN usuario ON usuario.id = backup.usuario_id ';    
        $join      .= 'INNER JOIN persona ON persona.id = usuario.persona_id ';       
        $conditions = "backup.id > 0";
        
        $order      = $this->get_order($order, 'backup.backup_at', array(
                        'nombre'=>array(
                            'ASC'=>'persona.nombre ASC, persona.apellido ASC', 
                            'DESC'=>'persona.nombre DESC, persona.apellido DESC'
                        ),
                        'apellido'=>array(
                            'ASC'=>'persona.apellido ASC, persona.nombre ASC', 
                            'DESC'=>'persona.apellido DESC, persona.nombre DESC'
                        ),
                        'fecha'=>array(
                            'ASC'=>'backup.backup_at ASC' ,
                            'DESC'=>'backup.backup_at DESC'
                        ),                                                                                            
                        'denominacion'=>array(
                            'ASC'=>'backup.denominacion ASC, backup.backup_at DESC' ,
                            'DESC'=>'backup.denominacion DESC, backup.backup_at DESC'
                        ),
                        'tamano'=>array(
                            'ASC'=>'backup.tamano ASC, backup.backup_at DESC' ,
                            'DESC'=>'backup.tamano DESC, backup.backup_at DESC'
                        )
                    )
        );
        
        //Por seguridad defino los campos habilitados para la búsqueda
        $fields = array('denominacion', 'nombre', 'apellido', 'fecha');
        if(!in_array($field, $fields)) {
            $field = 'nombre';
        }        
        
        if($field=='fecha') {
            $conditions.= " AND to_char(backup.backup_at,'YYYY-MM-DD') LIKE '%$value%'";
        } else {  
            $conditions.= " AND $field LIKE '%$value%'";
        }        
        
        if($page) {
            return $this->paginated("columns: $columns", "join: $join", "conditions: $conditions", "order: $order", "page: $page");
        } else {
            return $this->find("columns: $columns", "join: $join", "conditions: $conditions", "order: $order");
        }  
    }
    
    /**
     * Método para listar las copias de seguridad
     * @param type $order patrón de ordenamiento order.campo.tipo
     * @param type $page
     * @return type
     */
    public function getListadoBackup($order='', $page=0) {
        $columns    = 'backup.*, persona.nombre, persona.apellido';        
        $join       = 'INNER JOIN usuario ON usuario.id = backup.usuario_id ';     
        $join      .= 'INNER JOIN persona ON persona.id = usuario.persona_id ';      
        
        $order      = $this->get_order($order, 'backup.backup_at', array(
                        'nombre'=>array(
                            'ASC'=>'persona.nombre ASC, persona.apellido ASC', 
                            'DESC'=>'persona.nombre DESC, persona.apellido DESC'
                        ),
                        'apellido'=>array(
                            'ASC'=>'persona.apellido ASC, persona.nombre ASC', 
                            'DESC'=>'persona.apellido DESC, persona.nombre DESC'
                        ),
                        'fecha'=>array(
                            'ASC'=>'backup.backup_at ASC' ,
                            'DESC'=>'backup.backup_at DESC'
                        ),                                                                                            
                        'denominacion'=>array(
                            'ASC'=>'backup.denominacion ASC, backup.backup_at DESC' ,
                            'DESC'=>'backup.denominacion DESC, backup.backup_at DESC'
                        ),
                        'tamano'=>array(
                            'ASC'=>'backup.tamano ASC, backup.backup_at DESC' ,
                            'DESC'=>'backup.tamano DESC, backup.backup_at DESC'
                        )
                    )
        );
        
        if($page) {
            return $this->paginated("columns: $columns", "join: $join", "order: $order", "page: $page");
        } else {
            return $this->find("columns: $columns", "join: $join", "order: $order");
        }  
    }
    
    
    /**
     * Método para crear una copia de seguridad
     * 
     * @param type $data Input del post
     * @param string $path Ruta donde se almacenará la copia de seguridad
     * @param type $database Pull de conexión
     * @return boolean|\Backup
     */
    public static function createBackup($data, $path='', $database='') {
        $obj = new Backup($data);
        $obj->archivo = "backup-".($obj->count() + 1 ).".sql.gz";
        $obj->usuario_id = Session::get('id');
        //Inicio transacción
        ActiveRecord::beginTrans();
        if(!$obj->create()) {            
            ActiveRecord::rollbackTrans();
            return FALSE;
        }
        if(empty($path)) {
            $path = APP_PATH . 'temp/backup/';
        }
        if(!is_writable($path)) {
            ActiveRecord::rollbackTrans();
            Flash::error('Error: BKP-CRE001. El directorio de las copias de seguridad no tiene permisos de escritura.');
            return false;
        }        
        $file       = $path.$obj->archivo;
        
        $system = 'Linux'; 
        $database   = (empty($database)) ? Config::get('config.application.database') : $database;
        $config     = $obj->_getConfig($database);   

        if ($config['type']=='pgsql') {
            putenv("PGPASSWORD=" . $config['password']);
            $dumpcmd = array("pg_dump", "-i", "-U", $config['username'], "-F", "c", "-b", "-v", "-f", $file, $config['name']);
            system( join(' ', $dumpcmd), $cmdresult );
            putenv("PGPASSWORD");
        } else {    
            $system     = $obj->_getSystem(); 
            $exec       = "$system -h ".$config['host']." -u ".$config['username']." --password=".$config['password']." --opt --default-character-set=latin1 ".$config['name']." | gzip > $file";
            system($exec, $cmdresult);
        }

        if ($cmdresult != 0)
        {
            ActiveRecord::rollbackTrans();
            Flash::error('Error: BKP-CRE002. Se ha producido un error al intentar crear una nueva copia de seguridad.');
            return false;   
        }

        $tamano         = filesize($file);                
        $clase          = array(" Bytes", " KB", " MB", " GB", " TB"); 
        $obj->tamano    = round($tamano/pow(1024,($i = floor(log($tamano, 1024)))), 2 ).$clase[$i];
        $obj->update();
        @chmod($file, 0777);        
        ActiveRecord::commitTrans();
        if($obj) {
            DwAudit::debug("Se crea una copia de seguridad bajo la denominación: $obj->denominacion");
        }
        return $obj;         
    }
        
    /**
     * Callback que se ejecuta antes de guardar/modificar
     * @return string
     */
    public function before_save() {
        $conditions = "denominacion = '$this->denominacion'";
        $conditions.= (isset($this->id)) ? " AND id != $this->id" : '';
        if($this->count($conditions)) {
            Flash::error('Lo sentimos, pero ya existe una copia de seguridad con la misma denominación.');
            return 'cancel';
        }
    }
    
    /**
     * Método para restaurar el sistema
     * @param type $id
     */
    public static function restoreBackup($id, $path='') {
        $id         = Filter::get($id, 'int');
        if(empty($id)) {
            return FALSE;
        }
        if(empty($path)) {
            $path = APP_PATH . 'temp/backup/';
        }
        $obj        = new Backup();
        if(!$obj->find_first($id)) {
            Flash::error('Lo sentimos, pero no se ha podido establecer la información de la copia de seguridad.');
            return FALSE;
        }        
        $file       = $path.$obj->archivo;
        if(!is_file($file)) {
            Flash::error('Error: BKP-RES001. Se ha producido un error en la restauración del sistema. <br />No se pudo localizar el archivo de restaruación.');
            return FALSE;
        }
        //Almaceno las copias de seguridad anteriores
        $old_backup = $obj->find('order: backup_at ASC');
        $database   = Config::get('config.application.database'); //tomo el entorno actual
        $config     = $obj->_getConfig($database);//Tomo la configuración de conexión  

        if ($config['type']=='pgsql') {
            putenv("PGPASSWORD=" . $config['password']);
            $restorecmd = array($config['dbbinpath']."pg_restore", "-i", "--host", $config['host'], "--port", "5432", "--username", $config['username'], "--dbname", $config['name'], "--clean", "--schema", "public", "--verbose", $file);
            system( join(' ', $restorecmd), $cmdresult );
            putenv("PGPASSWORD");
        } else {   
            $system     = $obj->_getSystem(TRUE); //Verifico el sistema operativo para la restauración 
            $exec       = "gunzip < $file | $system -h ".$config['host']." -u ".$config['username']." --password=".$config['password']." ".$config['name'];
            system($exec, $cmdresult);
        }

        if($cmdresult==0) {
            //Inserto los backups anteriores
            foreach($old_backup as $backup) {
                if($backup->id >= $obj->id ) {
                    /*Kint::dump($obj->id); exit;*/
                    $obj->sql("INSERT INTO backup (id,usuario_id,denominacion,tamano,archivo,backup_at) VALUES ('$backup->id', '$backup->usuario_id', '$backup->denominacion', '$backup->tamano', '$backup->archivo', '$backup->backup_at')");
                }
            }          
            if($obj) {
                DwAudit::debug("Se ha restaurado el sistema con la copia de seguridad: $obj->denominacion");
            }
            return ($obj) ? $obj : FALSE;
        } else {
            Flash::error('Bandera..., $cmdresult (resultado del restore) no es Cero (0)');
            return FALSE;
        }
        
    }
       
    
}
?>
