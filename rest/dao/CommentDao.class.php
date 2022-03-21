<?php
require_once dirname(__FILE__)."/BaseDao.class.php";

class CommentDao extends BaseDao{
    public function __construct(){
        parent::__construct("comment");
    }

    //get comment, user_id za komentatora, comment body
    
    public function get_comments($search, $offset, $limit, $order, $total=FALSE){
        list($order_column, $order_direction) = self::parse_order($order);
    
        $params = [];
    
        if ($total){
          $query = "SELECT COUNT(*) AS total ";
        }else{
          $query = "SELECT * ";
        }
        $query .= "FROM comment ";
    
        if (isset($search)){
            $query .= "WHERE (LOWER(body) LIKE CONCAT('%', :search, '%'))";
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
    
      public function get_comment_by_post_id($id){
        $query = "SELECT user.user_name, body
        FROM comment
        JOIN user ON comment.user_id = user.id
        WHERE post_id = = :post_id";
        return $this->query($query, ["post_id"=>$id]);
    }
    

      public function get_user_comment_by_id($user_id, $id){
          return $this->query_unique("SELECT * FROM comment WHERE id = :id AND user_id = :user_id",["id" => $id, "user_id" => $user_id]);
      }
    }




?>