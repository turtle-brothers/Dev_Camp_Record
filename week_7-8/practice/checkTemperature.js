function checkTemperature(num) {
    if (30 >= num){
        console.log('Hot');
    }
    else if (num >= 15){
        console.log('Warm');
    }
    else{
        console.log('Cold');
    }
}

checkTemperature(30);
