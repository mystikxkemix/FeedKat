package polytech.feedkat;

import android.app.DownloadManager;
import android.content.Context;
import android.graphics.Bitmap;
import android.text.style.TtsSpan;
import android.util.LruCache;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

public class FeedKatAPI
{
    private static FeedKatAPI api = null;
    private Context _ctx;
    private RequestQueue mRequestQueue;
    private ImageLoader mImageLoader;
    private Boolean loggedIn = false;

    private boolean isLocal = false;
    //private String localServerAddr = "http://10.0.2.2:3000"; // localhost with emulator
    private String localServerAddr = "http://192.168.43.12:80/api/index.php";
    private String prodServerAddr = "http://feedkat.ddns.net:80/api/index.php";

    private FeedKatAPI(Context context)
    {
        _ctx = context;
        mRequestQueue = getRequestQueue();

        mImageLoader = new ImageLoader(mRequestQueue,
                new ImageLoader.ImageCache()
                {
                    private final LruCache<String, Bitmap> cache = new LruCache<String, Bitmap>(20);

                    @Override
                    public Bitmap getBitmap(String url) { return cache.get(url); }

                    @Override
                    public void putBitmap(String url, Bitmap bitmap) { cache.put(url, bitmap); }
                }
        );
    }

    public static FeedKatAPI getInstance(Context context)
    {
        if(api == null)
        {
            api = new FeedKatAPI(context);
        }
        return api;
    }

    public RequestQueue getRequestQueue()
    {
        if (mRequestQueue == null)
        {
            // getApplicationContext() is key, it keeps you from leaking the
            // Activity or BroadcastReceiver if someone passes one in.
            mRequestQueue = Volley.newRequestQueue(_ctx.getApplicationContext());
        }
        return mRequestQueue;
    }

    public final boolean getLoggedIn()
    {
        return loggedIn;
    }

    public VolleyError getVolleyError(int code, String message)
    {
        return new VolleyError("Error (#" + code + ") : " + message);
    }

    public <T> void addToRequestQueue(Request<T> req) { getRequestQueue().add(req); }

    // Methode

    public void login(String mail, String password, final Response.Listener<JSONObject> onSuccess, final Response.ErrorListener onError)
    {
        String link = isLocal ? localServerAddr : prodServerAddr;
        link+="/login";

        JSONObject parameter = new JSONObject();

        try
        {
            parameter.put("mail", mail);
            parameter.put("password", password);
        }
        catch (JSONException e)
        {
            e.printStackTrace();
            return;
        }

        JsonObjectRequest jsObjRequest = new JsonObjectRequest(Request.Method.POST, link, parameter, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response)
            {
                try {
                    Integer stat = response.getInt("error");

                    if(stat == 1)
                    {
                        onError.onErrorResponse(getVolleyError(101, "Error"));
                    }
                    else
                    {
                        onSuccess.onResponse(response);
                    }

                } catch (JSONException e) {
                    e.printStackTrace();
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error)
            {
                if (onError != null) onError.onErrorResponse(error);
            }
        });

        addToRequestQueue(jsObjRequest);
    }

    public void register(String mail, String password, String surname, String first_name, final Response.Listener<JSONObject> onSuccess, final Response.ErrorListener onError)
    {
        String link = isLocal ? localServerAddr : prodServerAddr;
        link+="/register";

        JSONObject params = new JSONObject();

        try {
            params.put("mail", mail);
            params.put("password", password);
            params.put("surname", surname);
            params.put("first_name", first_name);
        } catch (JSONException e) {
            e.printStackTrace();
            return;
        }

        JsonObjectRequest req = new JsonObjectRequest(Request.Method.POST, link, params, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response)
            {
                try {
                    if(response.getInt("error") == 0)
                    {
                        onSuccess.onResponse(response);
                    }
                    else
                    {
                        onError.onErrorResponse(getVolleyError(102, "User already exist"));
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                    return;
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error)
            {
                if (onError != null) onError.onErrorResponse(error);
            }
        });

        addToRequestQueue(req);
    }

    public void getUser(int id, final Response.Listener<JSONObject> onSuccess, final Response.ErrorListener onError)
    {
        String link = isLocal ? localServerAddr : prodServerAddr;
        link += "/user/"+id;

        JsonObjectRequest req = new JsonObjectRequest(Request.Method.GET, link, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response)
            {
                try {
                    if(response.getInt("error") == 0)
                    {
                        onSuccess.onResponse(response);
                    }
                    else
                    {
                        onError.onErrorResponse(getVolleyError(103, "User doesn't exist"));
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                    return;
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error)
            {
                if(onError != null) onError.onErrorResponse(error);
            }
        });

        addToRequestQueue(req);
    }

    public void getCatbyUserId(int id, final Response.Listener<JSONObject> onSuccess, final Response.ErrorListener onError)
    {
        String link = isLocal ? localServerAddr : prodServerAddr;
        link += "/cat/user/"+id;

        JsonObjectRequest req = new JsonObjectRequest(Request.Method.GET, link, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response)
            {
                try {
                    if(response.getInt("error") == 0)
                    {
                        onSuccess.onResponse(response);
                    }
                    else
                    {
                        onError.onErrorResponse(getVolleyError(103, "Utilisateur inconnu"));
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error)
            {
                onError.onErrorResponse(error);
            }
        });
        addToRequestQueue(req);
    }

    public void createCat(String name, final Response.Listener<JSONObject> onSuccess, final Response.ErrorListener onError)
    {
        String link = isLocal ? localServerAddr : prodServerAddr;
        link += "/cat";


        JSONObject params = new JSONObject();

        try {
            params.put("name", name);
        } catch (JSONException e) {
            e.printStackTrace();
            return;
        }

        JsonObjectRequest req = new JsonObjectRequest(Request.Method.POST, link, params, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response)
            {
                onSuccess.onResponse(response);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error)
            {
                if (onError != null) onError.onErrorResponse(error);
            }
        });

        addToRequestQueue(req);
    }

    public void getDispenserbyUserId(int id, final Response.Listener<JSONObject> onSuccess, final Response.ErrorListener onError)
    {
        String link = isLocal ? localServerAddr : prodServerAddr;
        link += "/dispenser/user/"+id;

        JsonObjectRequest req = new JsonObjectRequest(Request.Method.GET, link, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response)
            {
                try {
                    if(response.getInt("error") == 0)
                    {
                        onSuccess.onResponse(response);
                    }
                    else
                    {
                        onError.onErrorResponse(getVolleyError(103, "Utilisateur inconnu"));
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error)
            {
                onError.onErrorResponse(error);
            }
        });
        addToRequestQueue(req);
    }

    public void ModifyCat(int  id, String name,String birth, final Response.Listener<JSONObject> onSuccess, final Response.ErrorListener onError)
    {
        String link = isLocal ? localServerAddr : prodServerAddr;
        link+="/cat";

        JSONObject params = new JSONObject();

        try {
            params.put("id_cat", id);
            params.put("name", name);
            params.put("birth", birth);
        } catch (JSONException e) {
            e.printStackTrace();
            return;
        }

        JsonObjectRequest req = new JsonObjectRequest(Request.Method.POST, link, params, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response)
            {
                try {
                    if(response.getInt("error") == 0)
                    {
                        onSuccess.onResponse(response);
                    }
                    else
                    {
                        onError.onErrorResponse(getVolleyError(102, "This cat doesn't exist"));
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                    return;
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error)
            {
                if (onError != null) onError.onErrorResponse(error);
            }
        });

        addToRequestQueue(req);
    }


    public void ModifyFeedTime(int  id, int weight, String date, final Response.Listener<JSONObject> onSuccess, final Response.ErrorListener onError) {
        String link = isLocal ? localServerAddr : prodServerAddr;
        link += "/feedtimes";

        JSONObject params = new JSONObject();

        try {
            params.put("id_feedtime", id);
            params.put("weight", weight);
            params.put("time", date);
            System.out.println(date);
        } catch (JSONException e) {
            e.printStackTrace();
            return;
        }

        JsonObjectRequest req = new JsonObjectRequest(Request.Method.POST, link, params, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {
                try {
                    if (response.getInt("error") == 0) {
                        onSuccess.onResponse(response);
                    } else {
                        onError.onErrorResponse(getVolleyError(102, "This feedtime doesn't exist"));
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                    return;
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                if (onError != null) onError.onErrorResponse(error);
            }
        });

        addToRequestQueue(req);
    }

    public void AddFeedtime(int  id_cat, final Response.Listener<JSONObject> onSuccess, final Response.ErrorListener onError) {
        String link = isLocal ? localServerAddr : prodServerAddr;
        link += "/feedtimes";

        JSONObject params = new JSONObject();

        try {
            params.put("id_cat", id_cat);
            params.put("weight", 0);
            params.put("time", "00:00:00");
            params.put("enabled",1);
            params.put("id_dispenser",2);
        } catch (JSONException e) {
            e.printStackTrace();
            return;
        }

        JsonObjectRequest req = new JsonObjectRequest(Request.Method.PUT, link, params, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {
                try {
                    if (response.getInt("error") == 0) {
                        onSuccess.onResponse(response);
                    } else {
                        onError.onErrorResponse(getVolleyError(102, "This feedtime doesn't exist"));
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                    return;
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                if (onError != null) onError.onErrorResponse(error);
            }
        });

        addToRequestQueue(req);
    }
}
