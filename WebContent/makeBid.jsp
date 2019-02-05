
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<jsp:include page="head.jsp"></jsp:include>
<body>
	<%
		if ((session.getAttribute("user") != null)) {
			int u = Integer.parseInt(session.getAttribute("userID").toString());
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			String id = request.getParameter("itemID");
			int itemID = Integer.parseInt(id.toString());
			String torun = String.format("SELECT * FROM Items WHERE itemID = '%d'", itemID);
			String a = request.getParameter("amount");
			float amount = Float.parseFloat(a.toString());
			String auto = request.getParameter("automatic");
			int automatic = Integer.parseInt(auto.toString());

			ResultSet result = stmt.executeQuery(torun);
			int x = 0;
			Statement stmt2 = con.createStatement();
			String bids2 = String.format(
					"select * from Bids where itemID = '%d' AND amount= (SELECT max(amount) FROM Bids where itemID = '%d')",
					itemID, itemID);
			//System.out.println(bids2);

			ResultSet result2 = stmt2.executeQuery(bids2);
			Statement stmt3 = con.createStatement();
			String bids3 = String.format(
					"select * from Bids where itemID = '%d' AND amount= (SELECT min(amount) FROM Bids where itemID = '%d')",
					itemID, itemID);
			//System.out.println(bids3);
			ResultSet result3 = stmt3.executeQuery(bids3);
			long t = System.currentTimeMillis();
			java.sql.Timestamp curr = new java.sql.Timestamp(t);

			if (result.next()) {
				if (result.getTimestamp("endTime").after(curr)) {
					if (result2.next()) {
						System.out.println("hi");
						if (result3.next()) {
							//System.out.println("1");
							if ((result2.getFloat("amount") + result.getFloat("increment")) <= amount) {
								//System.out.println("2");
								if (Integer.parseInt(auto) == 0) {
									//System.out.println("3");
									//non automatic bidding
									if (result2.getInt("automaticBidding") == 1) {
										if (((result3.getFloat("amount") * -1)) >= amount
												+ result.getFloat("increment")) {
											System.out.println("automatic bidding, old automatic bidding, 1");
											String insert = "INSERT INTO Bids(bidId,buyerID,itemID,amount,automaticBidding,time)"
													+ " VALUES (?,?,?,?,?,?)";
											PreparedStatement ps = con.prepareStatement(insert);
											ps.setInt(1, x);
											ps.setInt(2, result3.getInt("buyerID"));
											ps.setInt(3, itemID);
											ps.setFloat(4, (amount) + result.getFloat("increment"));
											//old + 1?
											ps.setInt(5, 1);
											long h = System.currentTimeMillis();
											java.sql.Timestamp time = new java.sql.Timestamp(h);
											ps.setTimestamp(6, time);
											System.out.println(ps);
											ps.executeUpdate();

											String msg = "INSERT INTO Messages(senderID,receiverID,message,time)"
													+ "VALUES (?, ?, ?, ?)";
											PreparedStatement message = con.prepareStatement(msg);
											message.setInt(1, 5);
											message.setInt(2, u);
											message.setString(3, "you have been outbid on " + itemID);
											message.setTimestamp(4, time);
											message.executeUpdate();

											ps.setInt(1, x);
											ps.setInt(2, u);
											ps.setInt(3, itemID);
											ps.setFloat(4, amount);
											ps.setInt(5, 1);
											//long h = System.currentTimeMillis();
											//java.sql.Timestamp time = new java.sql.Timestamp(h);
											ps.setTimestamp(6, time);
											System.out.println(ps);
											ps.executeUpdate();

										} else if ((result3.getFloat("amount") * -1) >= amount) {
											System.out.println("nonautomatic bidding, old automatic bidding, 2");
											String insert = "INSERT INTO Bids(bidId,buyerID,itemID,amount,automaticBidding,time)"
													+ " VALUES (?,?,?,?,?,?)";
											PreparedStatement ps = con.prepareStatement(insert);
											ps.setInt(1, x);
											ps.setInt(2, result3.getInt("buyerID"));
											ps.setInt(3, itemID);
											ps.setFloat(4, (result3.getFloat("amount") * -1));
											ps.setInt(5, 1);
											long h = System.currentTimeMillis();
											java.sql.Timestamp time = new java.sql.Timestamp(h);
											ps.setTimestamp(6, time);
											//System.out.println(ps);
											ps.executeUpdate();

											ps.setInt(1, x);
											ps.setInt(2, u);
											ps.setInt(3, itemID);
											ps.setFloat(4, amount);
											ps.setInt(5, 1);
											//long h = System.currentTimeMillis();
											//java.sql.Timestamp time = new java.sql.Timestamp(h);
											ps.setTimestamp(6, time);
											//System.out.println(ps);
											ps.executeUpdate();

											String msg = "INSERT INTO Messages(senderID,receiverID,message,time)"
													+ "VALUES (?, ?, ?, ?)";
											PreparedStatement message = con.prepareStatement(msg);
											message.setInt(1, 5);
											message.setInt(2, u);
											message.setString(3, "you have been outbid on " + itemID);
											message.setTimestamp(4, time);
											message.executeUpdate();
										} else {
											System.out.println("nonautomatic bidding, old automatic bidding, 3");
											String insert = "INSERT INTO Bids(bidId,buyerID,itemID,amount,automaticBidding,time)"
													+ " VALUES (?,?,?,?,?,?)";
											PreparedStatement ps = con.prepareStatement(insert);
											ps.setInt(1, x);
											ps.setInt(2,
													Integer.parseInt(session.getAttribute("userID").toString()));
											ps.setInt(3, itemID);
											ps.setFloat(4, amount + result.getFloat("increment"));
											ps.setInt(5, 0);
											long h = System.currentTimeMillis();
											java.sql.Timestamp time = new java.sql.Timestamp(h);
											ps.setTimestamp(6, time);
											//System.out.println(ps);
											ps.executeUpdate();
											long ha = System.currentTimeMillis();
											java.sql.Timestamp newtime = new java.sql.Timestamp(ha);

											String msg = "INSERT INTO Messages(senderID,receiverID,message,time)"
													+ "VALUES (?, ?, ?, ?)";
											PreparedStatement message = con.prepareStatement(msg);
											message.setInt(1, 5);
											message.setInt(2, result2.getInt("buyerID"));
											message.setString(3, "you have been outbid on item number: " + itemID);
											message.setTimestamp(4, newtime);
											message.executeUpdate();

										}

									} else {
										long ha = System.currentTimeMillis();
										java.sql.Timestamp newtime = new java.sql.Timestamp(ha);

										String msg = "INSERT INTO Messages(senderID,receiverID,message,time)"
												+ "VALUES (?, ?, ?, ?)";
										PreparedStatement message = con.prepareStatement(msg);
										message.setInt(1, 5);
										message.setInt(2, result2.getInt("buyerID"));
										message.setString(3, "you have been outbid on item number: " + itemID);
										message.setTimestamp(4, newtime);
										message.executeUpdate();

										System.out.println("nonautomatic bidding, non oldautomatic bidding, 1");
										String insert = "INSERT INTO Bids(bidId,buyerID,itemID,amount,automaticBidding,time)"
												+ " VALUES (?,?,?,?,?,?)";
										PreparedStatement ps = con.prepareStatement(insert);
										ps.setInt(1, x);
										ps.setInt(2, Integer.parseInt(session.getAttribute("userID").toString()));
										ps.setInt(3, itemID);
										ps.setFloat(4, amount);
										ps.setInt(5, 0);
										long h = System.currentTimeMillis();
										java.sql.Timestamp time = new java.sql.Timestamp(h);
										ps.setTimestamp(6, time);
										System.out.println(ps);
										ps.executeUpdate();
									}
								} else {
									// automatic bidding
									if (result2.getInt("automaticBidding") == 1) {
										if (((result3.getFloat("amount") * -1)) >= amount
												+ result.getFloat("increment")) {
											System.out.println("automatic bidding if");
											String insert = "INSERT INTO Bids(bidId,buyerID,itemID,amount,automaticBidding,time)"
													+ " VALUES (?,?,?,?,?,?)";
											PreparedStatement ps = con.prepareStatement(insert);
											ps.setInt(1, x);
											ps.setInt(2, result3.getInt("buyerID"));
											ps.setInt(3, itemID);
											ps.setFloat(4, (amount) + result.getFloat("increment"));
											ps.setInt(5, 1);
											long h = System.currentTimeMillis();
											java.sql.Timestamp time = new java.sql.Timestamp(h);
											ps.setTimestamp(6, time);
											System.out.println(ps);
											ps.executeUpdate();

											String msg = "INSERT INTO Messages(senderID,receiverID,message,time)"
													+ "VALUES (?, ?, ?, ?)";
											PreparedStatement message = con.prepareStatement(msg);
											message.setInt(1, 5);
											message.setInt(2, result2.getInt("buyerID"));
											message.setString(3, "you have been outbid on " + itemID);
											message.setTimestamp(4, time);
											message.executeUpdate();

										} else if ((result3.getFloat("amount") * -1) >= amount) {
											System.out.println("automatic bidding else if");
											String insert = "INSERT INTO Bids(bidId,buyerID,itemID,amount,automaticBidding,time)"
													+ " VALUES (?,?,?,?,?,?)";
											PreparedStatement ps = con.prepareStatement(insert);
											ps.setInt(1, x);
											ps.setInt(2, result3.getInt("buyerID"));
											ps.setInt(3, itemID);
											ps.setFloat(4, (result3.getFloat("amount") * -1));
											ps.setInt(5, 1);
											long h = System.currentTimeMillis();
											java.sql.Timestamp time = new java.sql.Timestamp(h);
											ps.setTimestamp(6, time);
											System.out.println(ps);
											ps.executeUpdate();

											String msg = "INSERT INTO Messages(senderID,receiverID,message,time)"
													+ "VALUES (?, ?, ?, ?)";
											PreparedStatement message = con.prepareStatement(msg);
											message.setInt(1, 5);
											message.setInt(2, result2.getInt("buyerID"));
											message.setString(3, "you have been outbid on " + itemID);
											message.setTimestamp(4, time);
											message.executeUpdate();

										} else {
											System.out.println("automatic bidding, automatic bidding, 1");
											String insert = "INSERT INTO Bids(bidId,buyerID,itemID,amount,automaticBidding,time)"
													+ " VALUES (?,?,?,?,?,?)";
											PreparedStatement ps = con.prepareStatement(insert);
											ps.setInt(1, x);
											ps.setInt(2,
													Integer.parseInt(session.getAttribute("userID").toString()));
											ps.setInt(3, itemID);
											ps.setFloat(4, (result3.getFloat("amount") * -1
													+ result.getFloat("increment")));
											ps.setInt(5, 1);
											long h = System.currentTimeMillis();
											java.sql.Timestamp time = new java.sql.Timestamp(h);
											ps.setTimestamp(6, time);
											System.out.println(ps);
											ps.executeUpdate();

											long ha = System.currentTimeMillis();
											java.sql.Timestamp newtime = new java.sql.Timestamp(ha);

											String msg = "INSERT INTO Messages(senderID,receiverID,message,time)"
													+ "VALUES (?, ?, ?, ?)";
											PreparedStatement message = con.prepareStatement(msg);
											message.setInt(1, 5);
											message.setInt(2, result2.getInt("buyerID"));
											message.setString(3, "you have been outbid on item number: " + itemID);
											message.setTimestamp(4, newtime);
											message.executeUpdate();

											ps.setInt(1, x);
											ps.setInt(2,
													Integer.parseInt(session.getAttribute("userID").toString()));
											ps.setInt(3, itemID);
											ps.setFloat(4, amount * -1);
											ps.setInt(5, 1);
											ps.setTimestamp(6, time);
											System.out.println(ps);
											ps.executeUpdate();
										}
									} else {
										long ha = System.currentTimeMillis();
										java.sql.Timestamp newtime = new java.sql.Timestamp(ha);

										String msg = "INSERT INTO Messages(senderID,receiverID,message,time)"
												+ "VALUES (?, ?, ?, ?)";
										PreparedStatement message = con.prepareStatement(msg);
										message.setInt(1, 5);
										message.setInt(2, result2.getInt("buyerID"));
										message.setString(3, "you have been outbid on item number: " + itemID);
										message.setTimestamp(4, newtime);
										message.executeUpdate();

										System.out.println("automatic bidding, old nonautomatic bidding, 1");
										String insert = "INSERT INTO Bids(bidId,buyerID,itemID,amount,automaticBidding,time)"
												+ " VALUES (?,?,?,?,?,?)";
										PreparedStatement ps = con.prepareStatement(insert);
										ps.setInt(1, x);
										ps.setInt(2, Integer.parseInt(session.getAttribute("userID").toString()));
										ps.setInt(3, itemID);
										ps.setFloat(4, (result2.getFloat("amount") + result.getFloat("increment")));
										ps.setInt(5, 1);
										long h = System.currentTimeMillis();
										java.sql.Timestamp time = new java.sql.Timestamp(h);
										ps.setTimestamp(6, time);
										System.out.println(ps);
										ps.executeUpdate();

										ps.setInt(1, x);
										ps.setInt(2, Integer.parseInt(session.getAttribute("userID").toString()));
										ps.setInt(3, itemID);
										ps.setFloat(4, amount * -1);
										ps.setInt(5, 1);
										ps.setTimestamp(6, time);
										System.out.println(ps);
										ps.executeUpdate();
									}
								}
							}
						}
					} else {
						if (automatic == 1) {
							System.out.println("automatic bidding, no bids yet");
							String insert = "INSERT INTO Bids(bidId,buyerID,itemID,amount,automaticBidding,time)"
									+ " VALUES (?,?,?,?,?,?)";
							PreparedStatement ps = con.prepareStatement(insert);
							ps.setInt(1, x);
							ps.setInt(2, Integer.parseInt(session.getAttribute("userID").toString()));
							ps.setInt(3, itemID);
							ps.setFloat(4, result.getInt("startingBid"));
							ps.setInt(5, Integer.parseInt(auto));
							long h = System.currentTimeMillis();
							java.sql.Timestamp time = new java.sql.Timestamp(h);
							ps.setTimestamp(6, time);
							System.out.println(ps);
							ps.executeUpdate();

							ps.setInt(1, x);
							ps.setInt(2, Integer.parseInt(session.getAttribute("userID").toString()));
							ps.setInt(3, itemID);
							ps.setFloat(4, amount * -1);
							ps.setInt(5, Integer.parseInt(auto));
							ps.setTimestamp(6, time);
							System.out.println(ps);
							ps.executeUpdate();

						} else {
							if (amount >= result.getFloat("startingBid")) {
								System.out.println("not automatic bidding, no bids");
								String insert = "INSERT INTO Bids(bidId,buyerID,itemID,amount,automaticBidding,time)"
										+ " VALUES (?,?,?,?,?,?)";
								PreparedStatement ps = con.prepareStatement(insert);
								ps.setInt(1, x);
								ps.setInt(2, Integer.parseInt(session.getAttribute("userID").toString()));
								ps.setInt(3, itemID);
								ps.setFloat(4, amount);
								ps.setInt(5, Integer.parseInt(auto));
								long h = System.currentTimeMillis();
								java.sql.Timestamp time = new java.sql.Timestamp(h);
								ps.setTimestamp(6, time);
								System.out.println(ps);
								ps.executeUpdate();
							}
						}
					}
				}
				response.sendRedirect("viewAuctions.jsp");
				con.close();
			}
		}

		else {
	%>
	You are not logged in
	<br />
	<a href="login.jsp">Please Login</a>

	<%
		}
	%>

</body>
</html>