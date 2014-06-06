
! This test program is a template for a coupled-model simulation driver
! In the example, two models 'model1' and 'model2' are bidirectionally coupled
! so they need to exchange data between them at certain intervals, and 
! in the example, two physical domains are being modeled, for convenience
! and to avoid being too abstract, the domains are called 
! 'grl' for Greenland and 'ant' for Antarctica.

program test

    use model1 
    use model1_exchange 

    use model2 
    use model2_exchange 

    use coordinates 

    implicit none 

    type(model1_class) :: mod1_grl, mod1_ant 
    type(model2_class) :: mod2_grl, mod2_ant 


    integer :: year, day 

    ! Initialize model1 and model2 on each domain
    call model1_init(mod1_grl,...)
    call model1_init(mod1_ant,...)
    call model2_init(mod2_grl,...)
    call model2_init(mod2_ant,...)


    ! Begin time loop
    ! Send information to model1 every year from model2
    ! Send information to model2 every day from model1 
    do year = 1, 100
        do day = 1, 360

            ! Perform model1 calculations
            call model1_update(mod1_grl,year,day,...)
            call model1_update(mod1_ant,year,day,...)

            ! Send data to model2 every day
            call model2_exchange_model1(mod2_grl,mod1_grl)
            call model2_exchange_model1(mod2_ant,mod1_ant)
            
            ! Perform model2 calculations
            call model2_update(mod2_grl,year,day,...)
            call model2_update(mod2_ant,year,day,...)

        end do 

        ! Send data to model1 every year
        call model1_exchange_model2(mod1_grl,mod2_grl)
        call model1_exchange_model2(mod1_ant,mod2_ant)
        
        ! Check the average value of a variable called `var1` on each domain
        write(*,*) year, day, "var1 (grl,ant) = ", &
                   sum(mod1_grl%now%var1)/(mod1_grl%par%nx*mod1_grl%par%ny), &
                   sum(mod1_ant%now%var1)/(mod1_ant%par%nx*mod1_ant%par%ny)
    end do 


    return

end program test
