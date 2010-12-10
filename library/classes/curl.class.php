<?php
class cURL {

    # defaul global options
    var $opts = array(
            CURLOPT_HEADER => FALSE,
            CURLOPT_RETURNTRANSFER => TRUE
    );

    function cURL(){
    }

    function r($ch,$opt){
        # assign global options array
        $opts = $this->opts;
        # assign user's options
        foreach($opt as $k=>$v){$opts[$k] = $v;}
        curl_setopt_array($ch,$opts);
        curl_exec($ch);
        $r['code'] = curl_getinfo($ch,CURLINFO_HTTP_CODE);
        $r['cr'] = curl_exec($ch);
        $r['ce'] = curl_errno($ch);
        curl_close($ch);
        return $r;
    }

    function get($url='',$opt=array()){
        # create cURL resource
        $ch = curl_init($url);
        return $this->r($ch,$opt);
    }

    function post($url='',$data=array(),$opt=array()){
        # set POST options
        $opts[CURLOPT_POST] = TRUE;
        $opts[CURLOPT_POSTFIELDS] = $data;

        # create cURL resource
        $ch = curl_init($url);
        return $this->r($ch,$opt);
    }
};

?>