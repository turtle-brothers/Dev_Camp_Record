function Odd(arr) {
    for (const num of arr) {
        if (num % 2 == 1){
            console.log('ture');
        }else{
            console.log('false');
        }
    }
}

Odd([1, 2, 3, 4, 5]);



function hasOdd(arr) {
    for (const num of arr) {
        if (num % 2 == 1){
            console.log(num);
        }
    }
}

hasOdd([1, 2, 3, 4, 5]);


function square(arr) {
    for (const num of arr) {
        console.log(num*num);
    }
}


square([1, 2, 3, 4, 5])
