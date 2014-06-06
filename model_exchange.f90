
! This is a template for an exchange module defined for model1.
! This means that subroutines in this module pertain to sending
! information to model1 from different sources. In the example,
! only one subroutine is defined to take data from model2 to model1,
! but this would be the same to take data from model3, data_source, etc.
module model1_exchange 

    use model1 
    use model2 
    use coordinates 

    implicit none 


    private
    public :: model1_exchange_model2

contains

    subroutine model1_exchange_model2(mod1,mod2)

        implicit none 

        type(model1_class) :: mod1 
        type(model2_class) :: mod2 
        
        ! Exchange any important fields between two model domains
        ! interpolating if necessary, unit transformations, etc. 
        mod1%now%var1 = mod2%now%var1 
        mod1%now%var2 = mod2%now%var2 
        mod1%now%var3 = mod2%now%var3 

        return

    end subroutine model1_exchange_model2

end module model1_exchange 
