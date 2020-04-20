<?php
/**
 * Class Database
 */
class Database
{
    private $host       = "air-quality-db";
    private $user       = "root";
    private $password   = "d04kdzepq33kadf3qp314rm3o";
    private $db         = "iot2020";
    private $PDO;

    /**
     * Database constructor.
     */
    public function __construct() {
        $this->PDO = new PDO("mysql:host=$this->host;dbname=$this->db", $this->user, $this->password);
        $this->PDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $this->PDO->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_OBJ);
    }

    /**
     * @param $query
     * @param array|null $args
     * @return array
     */
    public function execute($query, Array $args = null) {
        $stmt = $this->PDO->prepare($query);

        // Arguments binding
        if(isset($args)) {
            foreach ($args as $arg) {
                $stmt->bindParam($arg[0], $arg[1], $arg[2]);
            }
        }

        $stmt->execute();
        return $stmt;
    }

    /**
     * @param $query
     * @param array|null $args
     * @return array
     */
    public function select($query, Array $args = null) {
        $stmt = $this->execute($query, $args);
        return $stmt->fetchAll();
    }
}

