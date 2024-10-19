const getTermOptions = () => {
    return [{label : '20 Years', value : '20'},
        {label : '25 Years', value : '25'},
        {label : '30 Years', value : '30'},
        {label : '35 Years', value : '35'},
        {label : '40 Years', value : '40'}
    ]
}

const calculateMonthlyPayment = (principal, years, rate) => {
    if(principal>0 && years>0 && rate>0){
        const monthlyRate = rate/100/12;
        const monthlyPayment = (principal*monthlyRate)/(1-Math.pow(1/(1+monthlyRate),years*12));
        return monthlyPayment;
    }
    return 0;
}

export {getTermOptions, calculateMonthlyPayment}