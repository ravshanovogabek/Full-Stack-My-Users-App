require 'sqlite3'
class User 
    #there we are creating an interface that creates, finds, get all users, updates and destroy users
    def makeHash(array)
        hash = Hash.new()
        hash['firstname']=array[0]
        hash['lastname']=array[1]
        hash['age']=array[2]
        hash['password']=array[3]
        hash['email']=array[4]
        return hash
        
    end
    #create user
    def create(user_info)
        begin 
            db = SQLite3:: Database.open "first_app.db"
            db.execute "INSERT INTO users VALUES('#{user_info[0]}', '#{user_info[1]}', '#{user_info[2]}', '#{user_info[3]}', '#{user_info[4]}')"
        rescue SQLite3::Exception => e
            puts "Exception occured"
            puts e
            
        ensure 
            id = db.last_insert_row_id
            puts "Successfully connected to db"
            db.close if db
            puts id
        end
    
    end
    #find user
    def find(user_id)
        begin 
            db = SQLite3:: Database.open "first_app.db"
            user = db.execute "SELECT * FROM users WHERE rowid=#{user_id}"
        rescue SQLite3::Exception => e
            puts "Exception occured"
            puts e
            
        ensure 
            db.close if db
            return makeHash(user[0])
        end
    end
    #get all users
    def all
        begin 
            db = SQLite3:: Database.open "first_app.db"
            user = db.execute "SELECT * FROM users"
        rescue SQLite3::Exception => e
            puts "Exception occured"
            puts e
            
        ensure 
            db.close if db
            hashArray = []
            for user in user
                hash = makeHash(user)
                hashArray.push(hash)
            end 
            return hashArray
        end
    
    end
    #update user
    def update(user_id, attribute, value)
        begin 
            db = SQLite3:: Database.open "first_app.db"
            db.execute "UPDATE users SET #{attribute}= #{value} WHERE rowid=#{user_id}"
        rescue SQLite3::Exception => e
            puts "Exception occured"
            puts e
            
        ensure 
            db.close if db
            p "Succeed"
        end
    end
    #destroy user
    def destroy(user_id)
        begin 
            db = SQLite3:: Database.open "first_app.db"
            db.execute "DELETE FROM users WHERE rowid=#{user_id}"
        rescue SQLite3::Exception => e
            puts "Exception occured"
            puts e
            
        ensure 
            db.close if db
            p "Succeed"
        end
    end
    def match(email, password)
        begin 
            db = SQLite3:: Database.open "first_app.db"
            id = db.execute "SELECT rowid FROM users WHERE email = '#{email}' AND password = '#{password}'"
        rescue SQLite3::Exception => e
            puts "Exception occured"
            puts e
            
        ensure 
            db.close if db
            p "Succeed"
            return id
        end
    end
end
#user = User.new()
#user.destroy(2)
#p user.find(1)
#user.create(['Morris', 'john', 42, 'qwert', 'qw@qw'])