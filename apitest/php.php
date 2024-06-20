<?php 
	header ('Content-Type: application/json; charset=utf-8');

	$dbhost="localhost";
    $dbusername="root";
    $dbpassword="123";
    $dbname="demo";
	
	$action = $_POST['action'];

    $conn = new mysqli($dbhost,$dbusername,$dbpassword,$dbname);
	if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
	
	if('CREATE_TABLE' == $action){
        $sql = "CREATE TABLE IF NOT EXISTS usersDemo (
            id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(30) NOT NULL,
            password VARCHAR(30) NOT NULL
            )";
        if ($conn->query($sql) === TRUE) {
            echo "success";
        } else {
            echo "error";
        }
        $conn->close();
        return;
    }
		
	if('SIGN_IN' == $action){
		$name = $_POST['USER_NAME'];
		$pass = $_POST['USER_PASSWORD'];
        $sql ="SELECT * FROM users WHERE name = '$name' AND password = '$pass'";
		$result=$conn->query($sql);
		if ($result->num_rows> 0) {
			$status ="status";
			
			$data="data";
			$ar=array();
			while($row=mysqli_fetch_assoc($result)){			
			 array_push($ar,$row);		 
			}		
			echo "{ 
					\"status\" : true,
			\"data\" : ".json_encode($ar)." } ";
		}else{
			echo "No record found";
		}
		$conn->close();
		return;	 
    }
	
	if('SIGN_UP' == $action){
		$name = $_POST['USER_NAME'];
		$pass = $_POST['USER_PASSWORD'];
		
		$sql ="SELECT * FROM users WHERE name = '$name' ";
		$result=$conn->query($sql);
		if ($result->num_rows> 0) {			
			echo "{ 
					\"status\" : false
			 } ";
		}else{
			$sql1 ="INSERT INTO users (name , password) VALUES ('$name' , '$pass') ";
			
			$resultS=$conn->query($sql1);
			
			if ($resultS === TRUE) {
				$id=$conn->insert_id;
				$sqlR ="CREATE TABLE IF NOT EXISTS friends".$id." (            
					fromWhom TEXT
					)";
				$resultR=$conn->query($sqlR);
			
				$sqlF ="CREATE TABLE IF NOT EXISTS requests".$id." (            
					fromWhom TEXT
					) ";			
				$resultF=$conn->query($sqlF);
				
				$sqlS ="CREATE TABLE IF NOT EXISTS sends".$id." (            
					fromWhom TEXT
					) ";
				$resultS=$conn->query($sqlS);
				
				if($resultF===true&&$resultR===true&$resultS===true){
					echo "{ 
						\"status\" : true } ";
				}else{
					
				}
					  	
			} else {
				echo "error";
			}
		}				    
        $conn->close();
        return;
    }
	
	if('GET_REQUESTS' == $action){
		$id = $_POST['USER_ID'];
		
		$sqlR ="CREATE TABLE IF NOT EXISTS requests".$id." (            
					fromWhom TEXT
					)";
		$conn->query($sqlR);
		
        $sql ="SELECT * FROM requests".$id." ";
		$result=$conn->query($sql);
		if ($result->num_rows> 0) {
			$status ="status";
			$data="data";
			$ar=array();			
			while($row=mysqli_fetch_assoc($result)){
			 array_push($ar,$row);		 
			}		
			echo "{ 
					\"status\" : true,
			\"data\" : ".json_encode($ar)." } ";
		}else{
			echo "{ 
					\"status\" : false
			} ";
		}
		$conn->close();
		return;	 		
	}
	
	if('GET_FRIENDS' == $action){
		$id = $_POST['USER_ID'];
		
		$sqlR ="CREATE TABLE IF NOT EXISTS friends".$id." (            
					fromWhom TEXT
					)";
		$conn->query($sqlR);
		
        $sql ="SELECT * FROM friends".$id." ";
		$result=$conn->query($sql);
		if ($result->num_rows> 0) {
			$status ="status";
			$data="data";
			$ar=array();			
			while($row=mysqli_fetch_assoc($result)){
				$idF=$row["fromWhom"];
				$sqlF ="SELECT * FROM users WHERE id = '$idF'";
				$resultF=$conn->query($sqlF);
				if ($resultF->num_rows> 0) {
					while($rowF=mysqli_fetch_assoc($resultF)){
						array_push($ar,$rowF);
					}					
				}						 
			}		
			echo "{ 
					\"status\" : true,
			\"data\" : ".json_encode($ar)." } ";
		}else{
			echo "{ 
					\"status\" : false
			} ";
		}
		$conn->close();
		return;	 		
	}
	
	if('SEND_REQUEST' == $action){
		$idS = $_POST['USER_ID'];
		$idR = $_POST['RECEIVER_ID'];
		
		$sqlS ="CREATE TABLE IF NOT EXISTS sends".$idS." (            
					fromWhom TEXT
					)";
		$conn->query($sqlS);
		$sqlR ="CREATE TABLE IF NOT EXISTS requests".$idR." (            
					fromWhom TEXT
					)";
		$conn->query($sqlR);
				
        $sql ="SELECT * FROM sends".$idS." WHERE fromWhom ='$idR' ";
		$result=$conn->query($sql);
		
		if ($result->num_rows> 0) {		
			$messageS="Already Sent";	
			echo "{ 
					\"status\" : false,
					\"message\" : \"".$messageS."\"
			} ";
		}else{
			$sqlF ="CREATE TABLE IF NOT EXISTS friends".$idS." (            
				fromWhom TEXT
				)";
			$conn->query($sqlF);

			$sqlF ="SELECT * FROM friends".$idS." WHERE fromWhom ='$idR' ";
			$resultF=$conn->query($sqlF);

			if ($resultF->num_rows> 0) {
				$messageF="Already Friend";			
				echo "{ 
					\"status\" : false,
					\"message\" : \"".$messageF."\"
				} ";
			}else{
				$sqlSend ="INSERT INTO sends$idS (fromWhom) VALUES ('$idR')";
				$sqlRequest ="INSERT INTO requests$idR (fromWhom) VALUES ('$idS')";
				if($conn->query($sqlSend)===true&&$conn->query($sqlRequest)===true){
					
					$sqlC ="CREATE TABLE IF NOT EXISTS notifications$idR 
							(id INTEGER PRIMARY KEY AUTO_INCREMENT , fromWhom TEXT, type TEXT, which TEXT, date TEXT, seen TEXT)";
					$conn->query($sqlC);
					
					$sqlN ="INSERT INTO notifications$idR (type,fromWhom,date,seen) VALUES ('friend_request_send' , '$idS','7/7/2022',0)";
					$conn->query($sqlN);
					
					echo "{ 
						\"status\" : true
					} ";
				}else{
					echo "error";
				}
			}	
		}
		$conn->close();
		return;	 		
	}
	
	if('ACCEPT_REQUEST' == $action){
		$idR = $_POST['USER_ID'];
		$idS = $_POST['SENDER_ID'];
		
		$sqlR ="CREATE TABLE IF NOT EXISTS friends".$idR." (            
					fromWhom TEXT
					)";
		$conn->query($sqlR);
		$sqlS ="CREATE TABLE IF NOT EXISTS friends".$idS." (            
					fromWhom TEXT
					)";
		$conn->query($sqlS);
				
        $sqlSender ="INSERT INTO friends".$idR." (fromWhom) VALUES ('$idS') ";
		$resultSender=$conn->query($sqlSender);
		
		$sqlReceiver ="INSERT INTO friends".$idS." (fromWhom) VALUES ('$idR') ";
		$resultReciver=$conn->query($sqlReceiver);
		
		$sqlDSender ="DELETE FROM requests$idR WHERE fromWhom ='$idS' ";
		$resultDSender=$conn->query($sqlDSender);
		
		$sqlDReceiver ="DELETE FROM sends$idS WHERE fromWhom ='$idR' ";
		$resultDReciver=$conn->query($sqlDReceiver);
		
		if ($resultSender===true && $resultReciver===true && $resultDSender===true && $resultDReciver===true) {
			
			$sqlC ="CREATE TABLE IF NOT EXISTS notifications$idS 
				(id INTEGER PRIMARY KEY AUTO_INCREMENT , fromWhom TEXT, type TEXT, which TEXT, date TEXT, seen TEXT)";
			$conn->query($sqlC);
			
			$sqlN ="INSERT INTO notifications$idS (type,fromWhom,date,seen) VALUES ('friend_request_accept' , '$idR','7/7/2022',0)";
			$conn->query($sqlN);
			
			echo "{ 
					\"status\" : true
			} ";
		}else{
			echo "{ 
				\"status\" : false
		} ";
		}
		$conn->close();
		return;	 		
	}
	
	if('DENY_REQUEST' == $action){
		$idR = $_POST['USER_ID'];
		$idS = $_POST['SENDER_ID'];
		
		$sqlDSender ="DELETE FROM requests$idR WHERE fromWhom ='$idS' ";
		$resultDSender=$conn->query($sqlDSender);
		
		$sqlDReceiver ="DELETE FROM sends$idS WHERE fromWhom ='$idR' ";
		$resultDReciver=$conn->query($sqlDReceiver);
		
		if ($resultDSender===true && $resultDReciver===true) {	
			echo "{ 
					\"status\" : true
			} ";
		}else{
			echo "{ 
				\"status\" : false
			} ";
		}
		$conn->close();
		return;	 		
	}

	if('DELETE_FRIEND' == $action){
		$idU = $_POST['USER_ID'];
		$idF = $_POST['FRIEND_ID'];
		
		$sqlU ="DELETE FROM friends$idU WHERE fromWhom ='$idF' ";
		$resultU=$conn->query($sqlU);
		
		$sqlF ="DELETE FROM friends$idF WHERE fromWhom ='$idU' ";
		$resultF=$conn->query($sqlF);
		
		if ($resultU===true && $resultF===true) {	
			echo "{ 
					\"status\" : true
			} ";
		}else{
			echo "{ 
				\"status\" : false
			} ";
		}
		$conn->close();
		return;	 		
	}

	if('GET_ALL_USERS' == $action){
		$sql ="SELECT * FROM users ";
		$result=$conn->query($sql);
		if ($result->num_rows> 0) {
			$status ="status";
			
			$data="data";
			$ar=array();
			while($row=mysqli_fetch_assoc($result)){			
			 array_push($ar,$row);		 
			}		
			echo "{ 
					\"status\" : true,
			\"data\" : ".json_encode($ar)." } ";
		}else{
			echo "No record found";
		}
		$conn->close();
		return;	 
	}
	 	 
	if('GET_USERS_BY_NAME' == $action){
		$name=$_POST['USER_NAME'];
	    $id=$_POST['USER_ID'];
		$sql ="SELECT * FROM users WHERE name LIKE '$name%' ";
		$result=$conn->query($sql);
		if ($result->num_rows> 0) {
			$status ="status";
			$data="data";
			$ar=array();

			while($row=mysqli_fetch_assoc($result)){		
				$idF=$row["id"];
				$sqlF ="SELECT * FROM friends".$id." WHERE fromWhom ='$idF' ";
				$resultF=$conn->query($sqlF);
				if ($resultF->num_rows> 0) {
					$row["relative"]="friend";
				}else{
					$sqlS ="SELECT * FROM sends".$id." WHERE fromWhom ='$idF' ";
					$resultS=$conn->query($sqlS);
					if ($resultS->num_rows> 0) {
						$row["relative"]="send";
					}else{
						$row["relative"]="stranger";
					}
				}
			 	array_push($ar,$row);		 
			}		
			echo "{ 
					\"status\" : true,
			\"data\" : ".json_encode($ar)." } ";
		}else{
			echo "{ 
					\"status\" : false
			 } ";
		}
		$conn->close();
		return;	 
	}
	 
	if('GET_NOTIFICATIONS' == $action){
		 
	    $id=$_POST['USER_ID'];
		$sqlC ="CREATE TABLE IF NOT EXISTS notifications$id 
				(id INTEGER PRIMARY KEY AUTO_INCREMENT , fromWhom TEXT, type TEXT, which TEXT, date TEXT, seen TEXT)";
		$resultC=$conn->query($sqlC);
		
		$sql ="SELECT * FROM notifications$id  ";
		$result=$conn->query($sql);
		if ($result->num_rows> 0) {
			$status ="status";
			$data="data";
			$ar=array();
			while($row=mysqli_fetch_assoc($result)){			
			 array_push($ar,$row);		 
			}		
			echo "{ 
					\"status\" : true,
			\"data\" : ".json_encode($ar)." } ";
		}else{
			echo "{ 
					\"status\" : false } ";
		}
		$conn->close();
		return;	 
	}

	if('MAKE_ALL_NOTIFICATIONS_SEEN' == $action){	
		$id=$_POST['USER_ID'];
		$sqlC ="CREATE TABLE IF NOT EXISTS notifications$id 
				(id INTEGER PRIMARY KEY AUTO_INCREMENT , fromWhom TEXT, type TEXT, which TEXT, date TEXT, seen TEXT)";
		$resultC=$conn->query($sqlC);
		
		$sql ="SELECT * FROM notifications$id WHERE seen ='0'";
		$result=$conn->query($sql);
		if ($result->num_rows> 0) {
			$status ="status";
			$data="data";
			while($row=mysqli_fetch_assoc($result)){	
				$idN =$row['id'];
				$sqlU="UPDATE notifications$id SET seen = '1' WHERE id='$idN'";
				$conn->query($sqlU);		
			}		
			echo "{ 
					\"status\" : true } ";
		}else{
			echo "{ 
					\"status\" : false } ";
		}
		$conn->close();
		return;	 
	}

	if('MAKE_NOTIFICATION_SEEN' == $action){
			
		$id=$_POST['USER_ID'];
		$idN=$_POST['NOTIFICATION_ID'];

		$sqlC ="CREATE TABLE IF NOT EXISTS notifications$id 
				(id INTEGER PRIMARY KEY AUTO_INCREMENT , fromWhom TEXT, type TEXT, which TEXT, date TEXT, seen TEXT)";
		$resultC=$conn->query($sqlC);
		
		$sql ="SELECT * FROM notifications$id WHERE id ='$idN'";
		$result=$conn->query($sql);
		if ($result->num_rows> 0) {
			$status ="status";
			$data="data";
			$sqlU="UPDATE notifications$id SET seen = '1' WHERE id='$idN'";
			$conn->query($sqlU);	
			echo "{ 
					\"status\" : true } ";
		}else{
			echo "{ 
					\"status\" : false } ";
		}
		$conn->close();
		return;	 
	}
	 
	if('GET_POSTS' == $action){
		$id = $_POST['USER_ID'];
        $sql ="SELECT * FROM posts WHERE fromWhom ='$id'";
		$result=$conn->query($sql);
		if ($result->num_rows> 0) {
			$status ="status";			
			$data="data";
			$ar=array();			
			while($row=mysqli_fetch_assoc($result)){
				$arC=array();
				$arL=array();
				$sqlC ="SELECT * FROM posts".$row["id"]."c";
				$resultC=$conn->query($sqlC);
				if ($resultC->num_rows> 0) {					
					while($rowC=mysqli_fetch_assoc($resultC)){
						if($rowC["fromWhom"]==$id){
							$rowC["isDeletable"]=true;
						}else{
							$rowC["isDeletable"]=false;
						}
						array_push($arC,$rowC);	
					}
				}				
				$sqlL ="SELECT * FROM posts".$row["id"]."L";
				$resultL=$conn->query($sqlL);
				if ($resultL->num_rows> 0) {
					while($rowL=mysqli_fetch_assoc($resultL)){
						array_push($arL,$rowL);	
					}
				}				
			 $row["Likes"]=$arL;
			 $row["Comments"]=$arC;
			 array_push($ar,$row);		 
			}		
			echo "{ 
					\"status\" : true,
			\"data\" : ".json_encode($ar)." } ";
		}else{
			echo "{ 
					\"status\" : false
			} ";
		}
		$conn->close();
		return;	 
    }
	
	if('CREATE_POST' == $action){
		$id = $_POST['USER_ID'];
		$text = $_POST['POST_TEXT'];
		$date =date("Y/m/d");
		
		$sqlp ="INSERT INTO posts (fromWhom , date,text) VALUES ('$id' , '$date' , '$text') ";			
		$resultP=$conn->query($sqlp);
		
		if ($resultP === TRUE) {
			$id=$conn->insert_id;
			$sqlL ="CREATE TABLE IF NOT EXISTS posts".$id."L (            
				fromWhom TEXT
				)";
			$resultL=$conn->query($sqlL);
		
			$sqlC ="CREATE TABLE IF NOT EXISTS posts".$id."C (            
				id INTEGER AUTO_INCREMENT PRIMARY KEY ,fromWhom TEXT,text TEXT
				) ";			
			$resultC=$conn->query($sqlC);
			
			if($resultL===true&&$resultC===true){
				echo "{ 
					\"status\" : true } ";
			}else{
				echo "{ 
					\"status\" : false } ";
			}
		}else{
			
		}	
	}
	
	if('ADD_COMMENT' == $action){
		$idU = $_POST['USER_ID'];
		$idP = $_POST['POST_ID'];
		$text = $_POST['COMMENT_TEXT'];
		
		$sqlC ="INSERT INTO posts".$idP."C (fromWhom ,text) VALUES ('$idU' , '$text') ";	
		$resultC=$conn->query($sqlC);
		
		if ($resultC === TRUE) {
			echo "{ 
				\"status\" : true } ";
	
		}else{
			
		}		
	}
	
	if('LIKE_REACTION' == $action){
		$idU = $_POST['USER_ID'];
		$idP = $_POST['POST_ID'];
		
		$sqlL ="SELECT * FROM posts".$idP."L WHERE fromWhom ='$idU' ";	
		$resultL=$conn->query($sqlL);
		
		if ($resultL->num_rows> 0) {
			$sqlLD ="DELETE FROM posts".$idP."L WHERE fromWhom ='$idU' ";	
			$resultLD=$conn->query($sqlLD);
			if($resultLD ==true){
				$msg ="deleted";
				echo "{ 
				\"status\" : true,
				\"msg\" : \"".$msg."\"} ";
			}else{
			}
			
		}else{
			$sqlLA ="INSERT INTO posts".$idP."L (fromWhom ) VALUES ('$idU')";	
			$resultLA=$conn->query($sqlLA);
			if($resultLA ==true){
				$msg ="added";
				echo "{ 
				\"status\" : true,
				\"msg\" : \"".$msg."\"} ";
			}else{
			}
		}		
	}
	
	if('DELETE_COMMENT' == $action){
		$idP = $_POST['POST_ID'];
		$idC = $_POST['COMMENT_ID'];
		
		$sqlC ="DELETE FROM posts".$idP."C WHERE id ='$idC' ";	
		$resultC=$conn->query($sqlC);
		
		if ($resultC === TRUE) {
			echo "{ 
				\"status\" : true } ";
	
		}else{
			
		}		
	}
	
	if('GET_COMMENTS'==$action){
		$idU = $_POST['USER_ID'];
		$idP = $_POST['POST_ID'];
		$arC=array();
		$sqlC ="SELECT * FROM posts".$idP."c";
		$resultC=$conn->query($sqlC);
		if ($resultC->num_rows> 0) {					
			while($rowC=mysqli_fetch_assoc($resultC)){
				if($rowC["fromWhom"]==$idU){
					$rowC["isDeletable"]=true;
				}else{
					$rowC["isDeletable"]=false;
				}
				array_push($arC,$rowC);	
			}
		}			
		echo "{ 
			\"status\" : true,
			\"data\" : ".json_encode($arC)." } ";
	}

	if('GET_LIKES'==$action){
		$idP = $_POST['POST_ID'];
		$arL=array();
		$sqlL ="SELECT * FROM posts".$idP."l";
		$resultL=$conn->query($sqlL);
		if ($resultL->num_rows> 0) {					
			while($rowL=mysqli_fetch_assoc($resultL)){
				array_push($arL,$rowL);	
			}
		}			
		echo "{ 
			\"status\" : true,
			\"data\" : ".json_encode($arL)." } ";
	}


?>