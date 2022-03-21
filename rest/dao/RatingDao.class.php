<?php 
require_once dirname(__FILE__)."/BaseDao.class.php";

class RatingDao extends BaseDao{
    public function __construct(){
        parent::__construct("rating");
    }
    


// get rating, submit rating, (admin-delete)

public function get_post_rating($id){

    return $this->query_unique("SELECT * FROM post p LEFT JOIN rating r ON p.id = r.post_id WHERE p.id = :id",["id"=>$id]);

}


public function get_ratings($search, $offset, $limit, $order, $total=FALSE){
  list($order_column, $order_direction) = self::parse_order($order);

  $params = [];

  if ($total){
    $query = "SELECT COUNT(*) AS total ";
  }else{
    $query = "SELECT * ";
  }
  $query .= "FROM rating ";

  if (isset($search)){
    $query .= "WHERE (LOWER(rating_value) LIKE CONCAT('%', :search, '%'))";
    $params['search'] = strtolower($search);
  }

  if ($total){
    return $this->query_unique($query, $params);
  }else{
    $query .="ORDER BY ${order_column} ${order_direction} ";
    $query .="LIMIT ${limit} OFFSET ${offset} ";

    return $this->query($query, $params);
  }
}




public function get_avg_rating($id){

    $value =  $this->query("SELECT AVG(rating_value) AS average
            FROM rating
            WHERE post_id = :post_id",["post_id"=>$id]);


    return $value[0]['average'];
}

public function rating_exists($user_id, $post_id){
    $value = $this->query("SELECT COUNT(user_id) AS total
                          FROM rating WHERE user_id = :user_id
                          AND post_id = :post_id",
                          ["user_id" => strtolower($user_id), "post_id" => $post_id]);
    if(($value[0]['total'])!=0){
      return true;
    }
    else{
      return false;
    }
  }


/*
base dao extends insert function

public function add_post_rating(id, post_id, user_id){
    return $this->query_unique("INSERT INTO rating (rating_value,post_id,user_id) VALUES ('3','2','2');  ",["id"=>$id]);
}

*/
}

 ?>