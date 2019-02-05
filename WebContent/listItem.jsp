<!DOCTYPE html>
<html>

<jsp:include page="head.jsp"></jsp:include>
<body>

<p><a href='home.jsp'>Go Back</a>
<form method = "post" action="newItem.jsp">
  Name of item:<br>
  <input type="text" name="name" required>
  <br>
  Category:<br>
  <select name="category" required>
	  		<option value="Ring">Ring</option>
	  		<option value="Necklace">Necklace</option>
	  		<option value="Watch">Watch</option>
  </select>
		<br>
	condition:<br>
  <input type="text" name="cond" required>
  <br>	
  brand:<br>
  <input type="text" name="brand" required>
  <br>	
  
  metal:<br>
  <input type="text" name="metal" required>
  <br>	
  
  stone:<br>
  <input type="text" name="stone" required>
  <br>	
  
  color:<br>
  <input type="text" name="color" required>
  <br>	

	
  <br>
         Description : <br />
         <textarea rows = "5" cols = "50" name = "description" required>
            
         </textarea>
         
    <br>	

	StartingBid:<br>
  <input type="number" step="0.01" name="startingBid" required >
  <br>	
   <br>	

	increment:<br>
  <input type="number" step="0.01" name="increment" required>
  <br>	
         
          <br>	

	minimum (reserve) price:<br>
  <input type="number" step="0.01" name="minimum">
  <br>	
          <br>	

	In how many hours do you want your auction to end?<br>
   <input type="number" step="0.01" name="date" required>
  <br>	
         <input type="submit">
         
      </form>

</body>
</html>