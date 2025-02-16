CREATE PROCEDURE usp_authenticate_user --'1','b'
	@login_id varchar(50),
	@login_password varchar(50)

AS
BEGIN
    SELECT
        U.User_ID as Id,
        U.first_name,
		U.last_name,
        U.Login_ID,
        U.password AS user_password,
        R.role_id,
        R.role_name,
        R.role_desc
    FROM MST_User U
    --INNER JOIN rel_employee_role R ON R.employee_id = U.id
    INNER JOIN mst_role R ON R.role_id = U.role_id
    WHERE U.IsActive = 1 AND R.IsActive = 1 
    AND trim(U.Login_ID) = @login_id; --AND U.password = login_password;
END