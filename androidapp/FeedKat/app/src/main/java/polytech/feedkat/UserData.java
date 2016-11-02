package polytech.feedkat;

/**
 * Created by olivierlafon on 21/10/2016.
 */

public class UserData {

    static int id_user = -1;
    static int index = 0;

    public UserData()
    {}

    public void setId_user(int id){
        id_user = id;
        return;
    }

    public void setIndex(int nb){
        index = nb;
        return;
    }
}
