<?php
require_once dirname(__FILE__)."/BaseDao.class.php";

class CategoryDao extends BaseDao{
    public function __construct(){
        parent::__construct("category");
    }
    


//ime kategorije 

public function get_categories($search, $offset, $limit, $order, $total=FALSE){
    list($order_column, $order_direction) = self::parse_order($order);

    $params = [];

    if ($total){    $query = "SELECT COUNT(*) AS total ";
    }else{  $query = "SELECT * ";
    }
    $query .= "FROM category ";
    if (isset($search)){
        $query .= "WHERE (LOWER(category_name) LIKE CONCAT('%', :search, '%'))";
        $params['search'] = strtolower($search);
    }
    if ($total){
      return $this->query_unique($query, $params);
    }else{
      $query .="ORDER BY ${order_column} ${order_direction} ";
      $query .="LIMIT ${limit} OFFSET ${offset}";

      return $this->query($query, $params);
    }
  }
//add kategoriju
  public function add_category($category){

      $data= [
        "category_name" => $category['category_name'],
      ];
       return parent::add($data);

  }
}


?>