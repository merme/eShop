SET DB=test.db

sqlite3 %DB% .schema

sqlite3 %DB% <%~n0.sql
