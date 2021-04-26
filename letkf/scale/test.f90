PROGRAM set_mem_node_proc
  IMPLICIT NONE
  INTEGER,PARAMETER :: mem=11, NUM_DOMAIN=1, MEMBER=10, LOG_LEVEL=2
  INTEGER :: tppn,tppnt,tmod
  INTEGER :: n,nn,m,q,qs,i,j,it,ip,ie
  INTEGER :: nnodes, nprocs_m, n_mem, n_mempn, nitmax, myrank, nens, mmean
  INTEGER :: mmean_rank_e, msprd_rank_e 
  INTEGER, PARAMETER :: nprocs=96, PPN=48
  INTEGER :: MEM_NODES=0
  INTEGER :: myrank_to_pe, nensobs, mmdetobs, mmdet, mmdetin, mmdet_rank_e
  INTEGER, ALLOCATABLE, DIMENSION(:) :: rank_to_pe, myrank_to_mem
  INTEGER, ALLOCATABLE, DIMENSION(:,:) :: mempe_to_node, mempe_to_rank, rank_to_mem, ranke_to_mem
  INTEGER, ALLOCATABLE, DIMENSION(:,:,:) :: rank_to_mempe
  LOGICAL :: DET_RUN=.false.
  LOGICAL :: myrank_use, DET_RUN_CYCLED
  INTEGER :: PRC_DOMAINS(1)=96

  write(*,*) "input myrank"
  read(*,*) myrank

  if (mod(nprocs, PPN) /= 0) then
    write(6,'(A,I10)') '[Info] Total number of MPI processes      = ', nprocs
    write(6,'(A,I10)') '[Info] Number of processes per node (PPN) = ', PPN
    write(6,'(A)') '[Error] Total number of MPI processes should be an exact multiple of PPN.'
    stop
  end if
  nnodes = nprocs / PPN

  ! (satoki): PRC_DOMAINS = number of total process in each domain
  nprocs_m = sum(PRC_DOMAINS(1:NUM_DOMAIN))

  if (LOG_LEVEL >= 1) then
    write(6,'(A,I10)') '[Info] Total number of MPI processes                = ', nprocs
    write(6,'(A,I10)') '[Info] Number of nodes (NNODES)                     = ', nnodes
    write(6,'(A,I10)') '[Info] Number of processes per node (PPN)           = ', PPN
    write(6,'(A,I10)') '[Info] Number of processes per member (all domains) = ', nprocs_m
  end if

  if (MEM_NODES == 0) then
    MEM_NODES = (nprocs_m-1) / PPN + 1  ! (satoki): node number per member
  end if
  IF(MEM_NODES > 1) THEN  ! (satoki): n_mem = total member (all domains), n_mempn = member per node (all domains)
    n_mem = nnodes / MEM_NODES
    n_mempn = 1
  ELSE
    n_mem = nnodes
    n_mempn = PPN / nprocs_m
  END IF
  nitmax = (mem - 1) / (n_mem * n_mempn) + 1
  tppn = nprocs_m / MEM_NODES
  tmod = MOD(nprocs_m, MEM_NODES)

  ALLOCATE(mempe_to_node(nprocs_m,mem))
  ALLOCATE(mempe_to_rank(nprocs_m,mem))
  ALLOCATE(rank_to_mem(nitmax,nprocs))
  ALLOCATE(rank_to_pe(nprocs))
  ALLOCATE(rank_to_mempe(2,nitmax,nprocs))
  ALLOCATE(ranke_to_mem(nitmax,n_mem*n_mempn))
  ALLOCATE(myrank_to_mem(nitmax))

  rank_to_mem = -1
  rank_to_pe = -1
  rank_to_mempe = -1
  ranke_to_mem = -1
  m = 1
mem_loop: DO it = 1, nitmax
    ie = 1
    DO i = 0, n_mempn-1
      n = 0
      DO j = 0, n_mem-1
        IF(m > mem .and. it > 1) EXIT mem_loop
        qs = 0
        DO nn = 0, MEM_NODES-1
          IF(nn < tmod) THEN
            tppnt = tppn + 1
          ELSE
            tppnt = tppn
          END IF
          DO q = 0, tppnt-1
            ip = (n+nn)*PPN + i*nprocs_m + q
            if (m <= mem) then
              mempe_to_node(qs+1,m) = n+nn
              mempe_to_rank(qs+1,m) = ip
            end if
            rank_to_mem(it,ip+1) = m      ! These lines are outside of (m <= mem) condition
            if (it == 1) then             ! in order to cover over the entire first iteration
              rank_to_pe(ip+1) = qs       ! 
            end if                        ! 
            rank_to_mempe(1,it,ip+1) = m  ! 
            rank_to_mempe(2,it,ip+1) = qs ! 
            qs = qs + 1
          END DO
        END DO
        if (m <= mem) then
          ranke_to_mem(it,ie) = m
        end if
        ie = ie + 1
        m = m + 1
        n = n + MEM_NODES
      END DO
    END DO
  END DO mem_loop

  DO it = 1, nitmax
    myrank_to_mem(it) = rank_to_mem(it,myrank+1)
  END DO
  myrank_to_pe = rank_to_pe(myrank+1)

  if (myrank_to_mem(1) >= 1) then
    myrank_use = .true.
  end if

  ! settings related to mean (only valid when mem >= MEMBER+1)
  !----------------------------------------------------------------
  if (mem >= MEMBER+1) then
    nens = mem
    mmean = MEMBER+1

    mmean_rank_e = mod(mmean-1, n_mem*n_mempn)

    msprd_rank_e = mmean_rank_e

    if (DET_RUN) then
      nensobs = MEMBER+1
      mmdetobs = MEMBER+1
    else
      nensobs = MEMBER
    end if
  end if

  ! settings related to mdet (only valid when mem >= MEMBER+2)
  !----------------------------------------------------------------
  if (mem >= MEMBER+2 .and. DET_RUN) then
    mmdet = MEMBER+2
    if (DET_RUN_CYCLED) then
      mmdetin = mmdet
    else
      mmdetin = mmean
    end if

    mmdet_rank_e = mod(mmdet-1, n_mem*n_mempn)
  end if

  write(*,*) "nitmax=", nitmax
  write(*,*) "myrank_to_mem=", myrank_to_mem
  write(*,*) "n_mem=", n_mem
  write(*,*) "n_mempn=", n_mempn
  write(*,*) "PRC_DOMAINS=", PRC_DOMAINS
  write(*,*) "mem=", mem
  write(*,*) "NUM_DOMAIN=", NUM_DOMAIN
  write(*,*) "MEMBER=", MEMBER
  write(*,*) "MEM_NODES=", MEM_NODES

END PROGRAM


